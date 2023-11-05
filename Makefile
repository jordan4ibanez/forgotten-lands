default:
	@echo Transpiling Forgotten Times into lua...
	@tl build
	@echo Successfully built Forgotten Times.

run: 
	@echo Transpiling Forgotten Times into lua...
	@tl build
	@echo Successfully built Forgotten Times.
	@echo Starting Minetest.
	@../../bin/minetest.exe