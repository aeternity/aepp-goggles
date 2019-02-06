<template>
    <app-panel>
        <app-table>
            <app-table-body>
                <app-table-row extend>
                    <app-table-row-cell extend>
                        <app-definition
                                type="list"
                                title="tx type"
                        >
                            {{ data.txType }}
                        </app-definition>
                    </app-table-row-cell>
                </app-table-row>
                <app-table-row extend >
                    <app-table-row-cell extend>
                        <app-definition
                                type="list"
                                title="tx"
                        >
                            {{ data.txHash }}
                        </app-definition>
                    </app-table-row-cell>
                </app-table-row>
                <app-table-row extend v-if="data.signature">
                    <app-table-row-cell extend>
                        <app-definition
                                type="list"
                                title="Signature"
                        >
                            {{ data.signature.hash }}
                            <p v-if="data.signature.error" class="error">{{ data.signature.error }}</p>
                        </app-definition>
                    </app-table-row-cell>
                </app-table-row>
                <app-table-row extend v-for="(result) in data.txObject" :key="result.id">
                    <app-table-row-cell extend>
                        <app-definition
                                type="list"
                                :title="result.title"
                        >
                            {{ result.value }}
                            <p v-if="result.error" class="error">{{ result.error }}</p>
                            <p v-if="result.warning" class="warning">{{ result.warning }}</p>
                        </app-definition>
                    </app-table-row-cell>
                </app-table-row>
            </app-table-body>
        </app-table>
    </app-panel>
</template>
<script>
    import AppDefinition from '../appDefinition'
    import AppPanel from '../appPanel'
    import AppTable from '../appTable'
    import AppTableBody from '../appTableBody'
    import AppTableRow from '../appTableRow'
    import AppTableRowCell from '../appTableRowCell'

    export default {
        name: 'gogglesResults',
        components: {AppDefinition, AppPanel, AppTable, AppTableBody, AppTableRow, AppTableRowCell},
        props: {
            data: {}
        }
    }
</script>
<style lang="scss">
    @import "../../../node_modules/@aeternity/aepp-components-3/src/styles/variables/colors";
    @import "../../../node_modules/@aeternity/aepp-components-3/src/styles/placeholders/typography";

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
