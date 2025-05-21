# defaults to linux, expects you to already have made the debugging world.
# @./scripts/clean_build_dir.sh
# @./scripts/compile_game.sh

defaults:
	@node --no-warnings=ExperimentalWarning ts_lua_project_bridge.ts
	@echo Starting Luanti.
	@luanti --go --gameid forgotten-lands --world $$HOME/.minetest/worlds/debugging

assets:
	@node --no-warnings=ExperimentalWarning ts_lua_project_bridge.ts --copy-media


watch:
	@npx tstl --watch

# dryrun:
# 	@./scripts/compile_game.sh

# windows: 
# 	@echo Transpiling Forgotten Times into lua...
# 	@npx tstl
# 	@echo Successfully built Forgotten Times.
# 	@echo Starting Luanti.
# 	@../../bin/luanti.exe

# linux:
# 	@./scripts/clean_build_dir.sh
# 	@./scripts/compile_game.sh
# 	@./scripts/copy_conf_files.sh
# 	@./scripts/copy_textures.sh
# 	@./scripts/copy_sounds.sh
# 	@./scripts/copy_models.sh
	
# 	@echo Starting Luanti.
# 	@minetest --go --gameid forgotten-lands --world $$HOME/.minetest/worlds/debugging

# build_linux:
# 	@./scripts/clean_build_dir.sh
# 	@./scripts/compile_game.sh
# 	@./scripts/copy_conf_files.sh
# 	@./scripts/copy_textures.sh
# 	@./scripts/copy_sounds.sh
# 	@./scripts/copy_models.sh


release:
	@node --no-warnings=ExperimentalWarning ts_lua_project_bridge.ts --rebuild-code --copy-media

# clean:
# 	@echo Destroying the built game.
# 	@rm --verbose -rf mods/

optimize_pngs:
	@./scripts/optimize_pngs.sh