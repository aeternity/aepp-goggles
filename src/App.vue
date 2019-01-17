<template>
  <div id="app">
    <div class="container">
      <div class="container__inner input">
        <h1 class="goggles"><span>G</span><span>o</span><span>g</span><span>g</span><span>l</span><span>e</span><span>s</span></h1>
        <div class="search-field">
          <div class="search-field__wrapper" :class="{ 'is-loading' : loading  }">
            <textarea rows="4" v-model="tx" class="search-field__input" @keydown.enter="toggle">
            </textarea>
            <ae-loader v-if="loading"/>
          </div>
          <p v-if="invalidTx" class="error error_signature">Invalid input</p>
          <p v-if="success" class="success">Your transaction looks good! 🤓</p>
          <button class="search-field__btn" @click="toggle" :disabled="loading" :class="{ disabled : loading }">{{ loading ? 'loading...' : 'verify'}}</button>
        </div>
        <div v-if="error" class="results" v-show="data">
          <app-panel>
            <app-table>
              <app-table-body>
                <app-table-row extend v-if="results.tx">
                  <app-table-row-cell extend>
                    <app-definition
                            type="list"
                            title="txgs"
                    >
                      {{ results.tx }}
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row extend v-if="results.signature">
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Signature"
                    >
                      {{ results.signature }}
                      <p v-if="error.ErrSignatureVerfication" class="error">The signature cannot be verified, please verify that you used the correct network id and the correct private key for the sender address
                      </p>
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row extend>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Sender account"
                    >
                      {{ results.txObject.senderId }}
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row extend>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Recipient account"
                    >
                      {{ results.txObject.recipientId }}
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Amount"
                    >
                      {{ results.txObject.amount }}
                      <p v-if="error.ErrInsufficientBalanceForAmount" class="error">The account balance <em>{{ error.ErrInsufficientBalanceForAmount }}</em> is not enough to execute the transaction</p>
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Ttl"
                    >
                      {{ results.txObject.ttl }}
                      <p v-if="error.ErrExpiredTTL" class="error">The TTL is already expired, the current height is <em>{{ error.ErrExpiredTTL }}</em></p>
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Fee"
                    >
                      {{ results.txObject.fee }}
                      <p v-if="error.ErrInsufficientBalanceForAmountFee" class="error">The account balance <em>{{ error.ErrInsufficientBalanceForAmountFee }}</em> is not enough to execute the transaction</p>
                      <p v-if="error.ErrInsufficientFee" class="error">The fee for the transaction is too low, the minimum fee for this transaction is <em>{{ error.ErrInsufficientFee }}</em></p>
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Nonce"
                    >
                      {{ results.txObject.nonce }}
                      <p v-if="error.ErrNonceUsed" class="error">The nonce is technically valid but will not be processed immediately by the node (next valid nonce is <em>{{ error.ErrNonceUsed }}</em>)</p>
                      <p v-if="error.WarnNonceHigh" class="error">The nonce is technically valid but will not be processed immediately by the node (next valid nonce is <em>{{ error.WarnNonceHigh }}</em>)</p>
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row extend>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Payload"
                    >
                      {{ results.txObject.payload }}
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
              </app-table-body>
            </app-table>
          </app-panel>
        </div>
      </div>

    </div>
  </div>
</template>

<script>
  import AppTableRow from './components/appTableRow'
  import AppTableRowCell from './components/appTableRowCell'
  import AppDefinition from './components/appDefinition'
  import AppTable from './components/appTable'
  import AppTableBody from './components/appTableBody'
  import AppPanel from './components/appPanel'
  import { AeLoader } from '@aeternity/aepp-components'

  import * as TxVerify from '../aepp-sdk-js-tx-verify/es/tx/deserializer'
export default {
  name: 'app',
  components: {
    AppTableRow,
    AppTableRowCell,
    AppDefinition,
    AppTable,
    AppTableBody,
    AppPanel,
    AeLoader
  },
  data: function () {
    return {
      tx: '',
      data: false,
      results: {},
      error: undefined,
      loading: false,
      invalidTx: false,
      unpackError: '',
      success: false
    }
  },
  methods: {
    toggle () {
      this.invalidTx = false;
      this.success = false;
      try {
        this.results = {};
        this.error = undefined;
        this.loading = true;
        this.results = TxVerify.unpackTx(this.tx.trim());
        TxVerify.verifyTx(this.results)
                .then(res => {
                  this.loading = false;
                  this.tx = '';
                  this.error = Object
                          .keys(res)
                          .reduce((acc, el) => {
                            if(res[el] !== true) acc[el] = res[el];
                            return acc
                          }, {})
                  this.success = Object.keys(this.error).length === 0;
                })
      } catch(e) {
        this.invalidTx = true;
        this.loading = false;
      }
      this.data = !this.data;
    }
  }
}
</script>

<style lang="scss">
  @import './styles/index';
  body {
    color: #001833;
  }
  ul, li {
    list-style: none;
  }
h1 {
  text-align: center;

  font-size: 4rem;
}
.goggles {
  & span:nth-child(1) {
    color: #5F4191;
  }
  & span:nth-child(2) {
    color: #E72B6E;
  }
  & span:nth-child(3) {
    color: #5F4191;
  }
  & span:nth-child(4) {
    color: #5F4191;
  }
  & span:nth-child(5) {
    color: #14CCB7;
  }
  & span:nth-child(6) {
    color: #E72B6E;
  }
  & span:nth-child(7) {
    color: #14CCB7;
  }
}
  .container {
    display: flex;
    flex-direction: column;
    min-height: 100vh;

    &__inner {
      width: 90%;
      max-width: 40em;
      margin: auto
    }
  }

  .search-field {
    display: flex;
    flex-direction: column;
    align-items: center;

    &__input {
      width: 100%;
      font-size: inherit;
      padding: .3rem;
      font-family: "IBM Plex Mono", monospace;
      border-radius: .5rem;
      border: 2px solid #EDF3F7;
      background-color: #EDF3F7;
      overflow: hidden;
      -webkit-appearance: none;
      resize: none;
      position: relative;
    }

    &__btn{
      padding: .5rem;
      border-radius: 1.2rem;
      font-family: inherit;
      font-size: .8rem;
      letter-spacing: .02rem;
      border: 1px solid transparent;
      background-color: #E72B6E;
      margin-top: 2rem;
      width: 40%;
      font-weight: 600;
      color: #fff;
      text-transform: uppercase;
      &.disabled {
        //opacity: .7;
        border: 2px solid #E72B6E;
        background-color: #fff;
        color: #E72B6E;
      }
    }

    &__wrapper {
      position: relative;
      width: 100%;

      & > .ae-loader {
        position: absolute;
        top: 38%;
        left: 47%;
        transform: translate(-50%, -50%);
      }
    }
  }

  .search-field__wrapper.is-loading > .search-field__input {
    opacity: .3;
  }
  .results {
    margin: 3rem 0;
  }

  .error {
    color: #E72B6E;
    font-size: .7rem;
    font-family: "Inter UI", sans-serif;
    background-color: #F7FAFC;
    font-weight: bold;
    width: 100%;
    margin-top: 0;
    @media (min-width: 450px) {
      background-color: #fff;
    }

    &_signature {
      background-color: transparent;
      margin-top: .5rem;
      margin-bottom: -.5rem;
      text-align: center;
    }
  }

</style>
