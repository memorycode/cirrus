return {
	lute = {
		lint = {
			-- Array of globbed strings, representing paths to exempt from linting
			ignores = {},
			-- Global values passed to each linting rule
			globals = {},
			-- Array of strings from which to load local lint rules
			rulepaths = {},
			-- Per rule overrides, with schema [RuleName] : {...}, where the schema is described below
			ruleconfigs = {
				-- [RuleName] : {,
				-- Array of globbed strings, representing paths exempt from this rule,
				-- ignores: {string}?,
				-- Override a rule's default severity,
				-- severity: ("warn" | "error" | "info" | "hint")?,
				-- Pass custom options through to a rule,
				-- options: { [string]: unknown }?,
				-- Disable this rule,
				-- off: boolean?,
				-- },
			},
		},
	},
	luau = {
		-- Default language mode to use for typechecking
		languagemode = "strict",
		-- Aliases for builtin libraries
		aliases = {
			lute = "~/.lute/typedefs/1.0.1/lute",
			std = "~/.lute/typedefs/1.0.1/std",
			lint = "~/.lute/typedefs/1.0.1/lint",
		},
	},
}
