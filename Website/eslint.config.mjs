import { defineConfig } from "eslint/config";
import globals from "globals";
import babelParser from "@babel/eslint-parser";
import path from "node:path";
import { fileURLToPath } from "node:url";
import js from "@eslint/js";
import { FlatCompat } from "@eslint/eslintrc";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const compat = new FlatCompat({
    baseDirectory: __dirname,
    recommendedConfig: js.configs.recommended,
    allConfig: js.configs.all
});

export default defineConfig([{
    extends: compat.extends("eslint:recommended"),

    languageOptions: {
        globals: {
            ...globals.browser,
        },

        parser: babelParser,
        ecmaVersion: "latest",
        sourceType: "module",

        parserOptions: {
            ecmaFeatures: {
                classes: true,
            },
        },
    },

    rules: {
        "brace-style": ["warn", "1tbs"],
        camelcase: "warn",
        "comma-dangle": ["warn", "always-multiline"],
        "comma-style": ["error", "last"],
        curly: "warn",
        "eol-last": ["error", "always"],
        "no-duplicate-imports": "error",
        eqeqeq: ["warn", "smart"],
        "no-eval": "error",
        "no-implied-eval": "error",
        "no-invalid-this": "error",
        "no-undefined": "error",
        "no-unused-expressions": "warn",
        "no-unused-vars": "warn",
        "no-use-before-define": "error",
        "no-const-assign": "error",
        semi: "error",
        "no-empty-function": "warn",
        "no-empty": "warn",
    },
}]);