<template>
    <h1 class="goggles-logo">
        <span>G</span><span>o</span><span>g</span><span>g</span><span>l</span><span>e</span><span>s</span>
    </h1>
</template>
<script>
    export default {
        name: 'gogglesLogo'
    }
</script>
<style lang="scss">
    @import "../../../node_modules/@aeternity/aepp-components-3/src/styles/variables/colors";
    @import "../../../node_modules/@aeternity/aepp-components-3/src/styles/placeholders/typography";

    h1 {
        text-align: center;
        font-size: 4rem;
    }

    .goggles-logo {
        position: relative;

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


</style>
