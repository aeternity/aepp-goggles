<template>
  <div id="app">
    <div class="container">
      <div class="container__inner input">
        <h1 class="goggles"><span>G</span><span>o</span><span>g</span><span>g</span><span>l</span><span>e</span><span>s</span></h1>
        <div class="search-field">
          <textarea rows="4" v-model="tx" class="search-field__input" @keydown.enter="toggle">
          </textarea>
          <button class="search-field__btn" @click="toggle">verify</button>
        </div>
        <div class="results" v-show="data">
          <app-panel>
            <app-table>
              <app-table-body>
                <app-table-row extend>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Signature"
                    >
                      ...
                      <p v-if="error.signature" class="error">The signature is unvalid</p>
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row extend>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Sender account"
                    >
                      ak_LAqgfAAjAbpt4hhyrAfHyVg9xfVQWsk1kaHaii6fYXt6AJAGe
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row extend>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Recipient account"
                    >
                      ak_Egp9yVdpxmvAfQ7vsXGvpnyfNq71msbdUpkMNYGTeTe8kPL3v
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Amount"
                    >
                      20054054081056290027
                      <p v-if="error.amount" class="error">The balance is insufficient</p>
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Ttl"
                    >
                      0
                      <p v-if="error.ttl" class="error">{{ error.ttl }}</p>
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Fee"
                    >
                      20000
                      <p v-if="error.fee" class="error">{{ error.fee }}</p>
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Nonce"
                    >
                      3
                      <p v-if="error.nonce" class="error">{{ error.nonce }}</p>
                    </app-definition>
                  </app-table-row-cell>
                </app-table-row>
                <app-table-row extend>
                  <app-table-row-cell extend>
                    <app-definition
                      type="list"
                      title="Payload"
                    >
                      ...
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

  import {TxVerify} from '@aeternity/aepp-sdk'

export default {
  name: 'app',
  components: {
    AppTableRow,
    AppTableRowCell,
    AppDefinition,
    AppTable,
    AppTableBody,
    AppPanel
  },
  data: function () {
    return {
      tx: '',
      data: false,
      results: {},
      error: {},
      unpackError: ''
    }
  },
  methods: {
    toggle () {
      try {
        this.results = TxVerify.unpackTx(this.tx);
        TxVerify.verifyTx(this.results)
                .then(res => this.error = res)
      } catch(e) {
        this.unpackError = e;
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
      border: 1px solid transparent;
      background-color: #EDF3F7;
      overflow: hidden;
      -webkit-appearance: none;
    }

    &__btn{
      padding: .5rem;
      border-radius:1rem;
      font-family: inherit;
      letter-spacing: .02rem;
      border: 1px solid transparent;
      background-color: #E72B6E;
      margin-top: 2rem;
      width: 40%;
      font-weight: 600;
      color: #fff;
      text-transform: uppercase;

    }
  }

  .results {
    margin: 3rem 0;
  }
</style>
