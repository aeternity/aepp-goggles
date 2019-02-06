<template>
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
                            <p v-if="warning.InsufficientBalanceForAmount" class="warning">{{
                                warning.InsufficientBalanceForAmount }}</p>
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
                            <p v-if="warning.InsufficientBalanceForAmountFee" class="warning">{{
                                warning.InsufficientBalanceForAmountFee }}</p>
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
</template>
<script>
    import AppDefinition from './components/appDefinition'
    import AppPanel from './components/appPanel'
    import AppTable from './components/appTable'
    import AppTableBody from './components/appTableBody'
    import AppTableRow from './components/appTableRow'
    import AppTableRowCell from './components/appTableRowCell'

    export default {
        name: 'gogglesResults',
        components: {AppDefinition, AppPanel, AppTable, AppTableBody, AppTableRow, AppTableRowCell},
        props: {
            error: {},
            results: {}
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
        margin: 0;
    }

    [v-cloak] {
        display: none
    }

    ul, li {
        list-style: none;
    }

    h1 {
        text-align: center;

        font-size: 4rem;
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


</style>