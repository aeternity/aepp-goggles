<template>
  <div id="app">
    <div class="container">
      <div class="version-tag">Beta</div>
      <div class="container__inner input">
        <gogglesLogo/>
        <div class="search-field">
          <label
            for="goggles"
            class="search-field__label"
          >💡 paste in transaction below to verify its validity</label>
          <div class="search-field__wrapper" :class="{ 'is-loading' : loading  }">
            <textarea
              v-model="txInput"
              id="goggles"
              class="search-field__input"
              @keydown.enter="validate"
              placeholder="tx_+LsLAfhCuEByfG/wPQ1EEuGRHQ/EsiW3ZCWKWKo07eYfr7Gwtsp+J6cW6ra9RzB4Rrh+RTgZH25SfbFBDDNIyA8zJDiCgoEFuHP4cQwBoQErhur1eJn/RBV05rwez1XXy/p0Zlghrxdc1gWlCHrKrqEBHxOjsIvwAUAGYqaLadh194A87EwIZH9u1dhMeJe9UKOJAaEVcvQZvTTrggPogkZQggu4l3lvdSBzaGFsbCBub3QgcGFzcyDwn5ikw1XokQ=="
            ></textarea>
            <ae-loader v-if="loading"/>
          </div>
          <p v-if="invalidTx" class="error error_signature">Invalid input</p>
          <p v-if="success" class="success">Your transaction looks good! 🤓</p>
          <button
            class="search-field__btn"
            @click="validate"
            :disabled="loading"
            :class="{ disabled : loading }"
          >{{ loading ? 'loading...' : 'verify'}}</button>
        </div>
        <div v-if="results" class="results">
          <gogglesResults :data="results"/>
        </div>
      </div>
    </div>
    <footer class="footer">
      <a href="https://aeternity.com/" target="_blank">
        <ae-logo/>
      </a>
      <div class="footer-container">
        <a href="https://aeternity.com/" target="_blank">aeternity.com</a>
        <a href="https://migrate.aeternity.com/#/legal" target="_blank">Imprint</a>
        <a href="https://github.com/aeternity/aepp-goggles">GitHub</a>
      </div>
      <small></small>
    </footer>
  </div>
</template>

<script>
import AeLogo from "../components/aeLogo";
import GogglesLogo from "../components/gogglesLogo";
import GogglesResults from "../components/gogglesResults";
import { AeLoader } from "@aeternity/aepp-components";
import TxValidator from "@aeternity/aepp-sdk/es/tx/validator";
import router from '../router'

const NODE_URL = "https://sdk-mainnet.aepps.com";
const NODE_INTERNAL_URL = "https://sdk-mainnet.aepps.com";
const NETWORK_ID = "ae_mainnet";

export default {
  name: 'app',
  components: {
    GogglesResults,
    GogglesLogo,
    AeLoader,
    AeLogo
  },
  props: {
    tx: {
      type: String,
      required: false
    } // this is to retrieve TX has from "//URL/tx/URL_ENCODED_TX_HASH
  },
  data: function() {
    return {
      results: null,
      data: false,
      error: undefined,
      loading: false,
      invalidTx: false,
      success: false,
      txValidator: undefined
    };
  },
  computed: {
    txInput: {
      get: function() {
        return this.tx;
      },
      set: function(newTxHash) {
        router.push({ name: 'tx', params: { tx: newTxHash } })
        this.$emit('update:tx', newTxHash)
      },
    }
  },
  async created() {
    this.txValidator = await TxValidator({
      url: NODE_URL,
      internalUrl: NODE_INTERNAL_URL,
      networkId: NETWORK_ID
    });
  },
  methods: {
    clear() {
      this.invalidTx = false;
      this.success = false;
      this.results = null;
    },
    onError() {
      this.invalidTx = true;
      this.loading = false;
    },
    clearInput() {
      this.tx = '';
    },
    mapValidationAndTx(data) {
      const signatureError = data.validation.find(
        v => v['txKey'] === 'signature'
      );
      if (data.signatures && data.signatures[0])
        data.signature = {
          ...data.signatures[0],
          error: signatureError && signatureError.msg
        };

      return {
        ...data,
        txObject: Object.entries(data.tx).reduce((acc, [key, value]) => {
          const validation = data.validation.reduce(
            (acc, { txKey, type, msg }) => {
              if (key === txKey) acc[type] = msg;
              return acc;
            },
            {}
          );

          acc[key] = { value, ...validation, title: key };
          return acc;
        }, {})
      };
    },
    validate() {
      this.clear();
      this.loading = true;
      const base64regex = /^([0-9a-zA-Z+/]{4})*(([0-9a-zA-Z+/]{2}==)|([0-9a-zA-Z+/]{3}=))?$/;

      try {
        if (
          this.tx.trim().split('_')[0] !== 'tx' ||
          !base64regex.test(this.tx.trim().slice(3))
        )
          throw new Error('Invalid Transaction Hash');

        this.txValidator.unpackAndVerify(this.tx.trim()).then(data => {
          this.loading = false;

          if (!Object.keys(data.validation).length) this.success = true;
          else
            this.results = {
              txHash: this.tx,
              ...this.mapValidationAndTx(data)
            };

          this.clearInput();
        });
      } catch (e) {
        this.onError(e);
      }
    }
  }
};
</script>