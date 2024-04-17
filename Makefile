# defaults to linux, expects you to already have made the debugging world.
default:
	@./scripts/clean_build_dir.sh
	@./scripts/compile_game.sh
	@./scripts/copy_conf_files.sh
	@./scripts/copy_textures.sh
	@./scripts/copy_sounds.sh
	@./scripts/copy_models.sh

	@echo Starting Minetest.
	@minetest --go --gameid forgotten-lands --world $$HOME/.minetest/worlds/debugging

dryrun:
	@./scripts/compile_game.sh

windows: 
	@echo Transpiling Forgotten Times into lua...
	@npx tstl
	@echo Successfully built Forgotten Times.
	@echo Starting Minetest.
	@../../bin/minetest.exe

linux:
	@./scripts/clean_build_dir.sh
	@./scripts/compile_game.sh
	@./scripts/copy_conf_files.sh
	@./scripts/copy_textures.sh
	@./scripts/copy_sounds.sh
	@./scripts/copy_models.sh
	
	@echo Starting Minetest.
	@minetest --go --gameid forgotten-lands --world $$HOME/.minetest/worlds/debugging

build_linux:
	@./scripts/clean_build_dir.sh
	@./scripts/compile_game.sh
	@./scripts/copy_conf_files.sh
	@./scripts/copy_textures.sh
	@./scripts/copy_sounds.sh
	@./scripts/copy_models.sh


release:
	@./scripts/make_release.sh

clean:
	@echo Destroying the built game.
	@rm --verbose -rf mods/
	@echo "It's done."

optimize_pngs:
	@./scripts/optimize_pngs.sh