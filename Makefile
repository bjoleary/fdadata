all: install
data:
	$(info ** Updating Datasets **)
	R -q -e "testthat::source_dir('data-raw')"
readme: README.Rmd
	$(info ** Updating README **)
	R -q -e "devtools::build_readme()"
document:
	$(info ** Updating Documentation **)
	R -q -e "devtools::document()"
install: data document readme
	$(info ** Installing Package **)
	R -q -e "devtools::install(upgrade = TRUE)"
