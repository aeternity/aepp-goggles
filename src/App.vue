<template>
  <div id="app">
    <div id="nav">
      <!-- <router-link to="/">Home</router-link> |
      <router-link to="/about">About</router-link> -->
    </div>
    <router-view/>
  </div>
</template>

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
        cursor: url('assets/goggles_cursor.png'), auto;
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

    .version-tag {
        color: #fff;
        background-color: #000;
        font-size: .8rem;
        font-weight: 600;
        line-height: 0;
        position: absolute;
        text-transform: uppercase;
        top: 1rem;
        right: 1rem;
        margin: 0 0 0 .5rem;
        padding: .8rem;
        border-radius: .3rem;
    }


    .container {
        display: flex;
        flex-direction: column;
        min-height: 85vh;

        &__inner {
            width: 90%;
            max-width: 40em;
            margin: auto;
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
            min-height: 6rem;
            font-family: "IBM Plex Mono", monospace;
            border: 2px solid $color-neutral-positive-2;
            background-color: $color-neutral-positive-2;
            -webkit-appearance: none;
            // resize: height;
            position: relative;
            border-radius: .5rem .5rem 0 .5rem;
            overflow: hidden;
            word-break: break-all;
            cursor: initial;

            &:focus {
                outline: none;
                border-radius: .5rem;
                border: 2px solid $color-neutral-positive-1;
            }

            &::placeholder {
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

                &:not(:last-child) {
                    margin-right: 1rem;
                }
            }
        }
    }
</style>
