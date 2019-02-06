<template>
    <div id="app">
            <div class="container">
            <div class="version-tag">Beta</div>
            <div class="container__inner input">
                <gogglesLogo/>
                <div class="search-field">
                    <label for="goggles" class="search-field__label">
                        💡 paste in transaction below to verify its validity
                    </label>
                    <div class="search-field__wrapper" :class="{ 'is-loading' : loading  }">
                        <textarea
                                rows="5"
                                v-model="tx"
                                id="goggles"
                                class="search-field__input"
                                @keydown.enter="validate"
                                placeholder="tx_+LsLAfhCuEByfG/wPQ1EEuGRHQ/EsiW3ZCWKWKo07eYfr7Gwtsp+J6cW6ra9RzB4Rrh+RTgZH25SfbFBDDNIyA8zJDiCgoEFuHP4cQwBoQErhur1eJn/RBV05rwez1XXy/p0Zlghrxdc1gWlCHrKrqEBHxOjsIvwAUAGYqaLadh194A87EwIZH9u1dhMeJe9UKOJAaEVcvQZvTTrggPogkZQggu4l3lvdSBzaGFsbCBub3QgcGFzcyDwn5ikw1XokQ==">
                        </textarea>
                        <ae-loader v-if="loading"/>
                    </div>
                    <p v-if="invalidTx" class="error error_signature">Invalid input</p>
                    <p v-if="success" class="success">Your transaction looks good! 🤓</p>
                    <button class="search-field__btn" @click="validate" :disabled="loading"
                            :class="{ disabled : loading }">{{ loading ? 'loading...' : 'verify'}}
                    </button>
                </div>
                <div v-if="error" class="results">
                    <app-panel>
                        <app-table>
                            <app-table-body>
                                <app-table-row extend v-if="results.tx">
                                    <app-table-row-cell extend>
                                        <app-definition
                                                type="list"
                                                title="tx"
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
                                            <p v-if="error.InvalidSignature" class="error">{{ error.InvalidSignature }}</p>
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
                                            <p v-if="warning.InsufficientBalanceForAmount" class="warning">{{ warning.InsufficientBalanceForAmount }}</p>
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
                                            <p v-if="error.ExpiredTTL" class="error">{{ error.ExpiredTTL }}</p>
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
                                            <p v-if="warning.InsufficientBalanceForAmountFee" class="warning">{{ warning.InsufficientBalanceForAmountFee }}</p>
                                            <p v-if="error.InsufficientFee" class="error">{{ error.InsufficientFee }}</p>
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
                                            <p v-if="error.NonceUsed" class="error">{{ error.NonceUsed }}</p>
                                            <p v-if="warning.NonceHigh" class="warning">{{ warning.NonceHigh }}</p>
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
        <footer class="footer">
            <a href="https://aeternity.com/" target="_blank">
                <ae-logo/>
            </a>
            <div class="footer-container">
                <a href="https://aeternity.com/" target="_blank">
                    aeternity.com
                </a>
                <a href="https://migrate.aeternity.com/#/legal" target="_blank">
                    Imprint
                </a>
            </div>
            <small></small>
        </footer>
    </div>
</template>

<script>
    import AppTableRow from './components/appTableRow'
    import AppTableRowCell from './components/appTableRowCell'
    import AppDefinition from './components/appDefinition'
    import AppTable from './components/appTable'
    import AppTableBody from './components/appTableBody'
    import AppPanel from './components/appPanel'
    import AeLogo from './components/aeLogo'
    import GogglesLogo from "./components/gogglesLogo";
    import {AeLoader} from '@aeternity/aepp-components'

    import TxValidator from '@aeternity/aepp-sdk/es/tx/validator'
    import * as TxBuilder from '@aeternity/aepp-sdk/es/tx/builder'
    import * as TxHelper from '@aeternity/aepp-sdk/es/tx/builder/helpers'


    const NODE_URL = 'https://sdk-mainnet.aepps.com';
    const NODE_INTERNAL_URL = 'https://sdk-mainnet.aepps.com';
    const NETWORK_ID = 'ae_mainnet';

    export default {
        name: 'app',
        components: {
            GogglesLogo,
            AppTableRow,
            AppTableRowCell,
            AppDefinition,
            AppTable,
            AppTableBody,
            AppPanel,
            AeLoader,
            AeLogo
        },
        data: function () {
            return {
                tx: '',
                data: false,
                results: {},
                error: undefined,
                loading: false,
                invalidTx: false,
                success: false,
                txValidator: undefined
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
                this.results = {};
                this.error = {};
                this.warning = {};
            },
            onError() {
                this.invalidTx = true;
                this.loading = false;
                //console.error(e);
            },
            clearInput() {
                this.tx = '';
            },
            unpackTx () {
                const { tx } = TxBuilder.unpackTx(this.tx.trim());
                this.results.txObject = tx;

                if (tx.signatures) {
                    this.results.signature = TxHelper.encode(tx.signatures[0], 'sg');
                    this.results.txObject = tx.encodedTx.tx;
                }
            },
            validate() {
                this.clear();
                this.loading = true;
                try {
                    this.results.tx = this.tx;

                    // TODO remove that extracting when upgrade to sdk 1.3.3 (unpack and verify will handle it)
                    this.unpackTx();

                    this.txValidator.unpackAndVerify(this.tx.trim())
                        .then(({ error, warning }) => {
                            this.loading = false;
                            this.clearInput();
                            this.error = error;
                            this.warning = warning;
                            this.success = Object.keys(this.error).length === 0 && Object.keys(this.warning).length === 0;
                        })
                } catch (e) {
                    this.onError(e)
                }
            }
        }
    }
</script>

<style lang="scss">
    @import "~@aeternity/aepp-components-3/src/styles/variables/colors";
    @import "~@aeternity/aepp-components-3/src/styles/placeholders/typography";
    html {
        @extend %face-sans-base;
        font-size: 18px;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        text-rendering: optimizeLegibility;
        box-sizing: border-box;
        caret-color: $color-primary;
    }
    *, *:before, *:after {
        box-sizing: inherit;
    }

    body {
        color: #001833;
        margin:0;
    }
    [v-cloak] {
        display:none
    }
    ul, li {
        list-style: none;
    }

    h1 {
        text-align: center;

        font-size: 4rem;
    }

    .version-tag {
        color: #fff;
        font-size: .8rem;
        font-weight: 600;
        line-height: 0;
        position: absolute;
        text-transform: uppercase;
        top: 1rem;
        right: 1rem;
        margin: 0;
        padding: 0;
        margin-left: .5rem;
        color: #fff;
        background-color: #000;
        padding: .8rem;
        border-radius: .3rem;
    }


    .container {
        display: flex;
        flex-direction: column;
        min-height: 90vh;

        &__inner {
            width: 90%;
            max-width: 40em;
            margin: auto;
            padding: 25% 0;
        }
    }

    .search-field {
        display: flex;
        flex-direction: column;
        align-items: center;
        &__label {
            @extend %face-uppercase-xs;
            color: $color-neutral-negative-1;
            margin: 1.5rem 0;
            text-align: center;
        }
        &__input {
            width: 100%;
            display: block;
            font-size: .9rem;
            padding: .3rem;
            font-family: "IBM Plex Mono", monospace;
            border: 2px solid $color-neutral-positive-2;
            background-color: $color-neutral-positive-2;
            -webkit-appearance: none;
            resize: none;
            position: relative;
            border-radius: .5rem;
            overflow: hidden;
            word-break: break-all;
            cursor: url('assets/goggles_cursor.png'), auto;
            &:focus {
                outline: none;
                border-radius: .5rem;
                border: 2px solid $color-neutral-positive-1;
            }
            &::placeholder {
                //font-size: .8rem;
                opacity: .5;
            }
        }
        &__btn {
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
            cursor: url('assets/goggles_cursor_w.png'), pointer;

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

    .warning {
        color: #5F4191;
        font-size: .7rem;
        font-family: "Inter UI", sans-serif;
        background-color: #F7FAFC;
        font-weight: bold;
        width: 100%;
        margin-top: 0;
        opacity: .8;
        @media (min-width: 450px) {
            background-color: #fff;
        }
    }


    .app-definition-content {
        word-break: break-word;
    }

    .footer {
        display: flex;
        //width: 90%;
        margin: 1.5rem;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        font-size: .8rem;
        &-container {
            display: flex;
            margin: .3rem 0;
            & a {
                //font-size: .8rem;
                color: $color-neutral-minimum;
                display: inline-block;
                text-decoration: none;
                text-align: center;
                &:first-child {
                    margin-right: 1rem;
                }
            }
        }
    }
</style>
