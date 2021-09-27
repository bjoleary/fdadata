documentation := $(man/*.Rd)
scripts := $(R/*.R)
r_opts := -q -e
update := data-raw/update.txt

all: $(update) data document install

# Make all data
data: data/pmn.rda data/pma.rda R/pmn.R R/pma.R $(update)
	$(info ** Updated Datasets **)

# Force data update 
$(update): 
	$(info ** Forcing Dataset Updates **)
	touch $(update)

# Individual datasets
data/pmn.rda R/pmn.R: data-raw/pmn.R $(update)
	$(info ** Updating pmn Dataset **)
	R $(r_opts) "source('$<')"

data/pma.rda R/pma.R: data-raw/pma.R $(update)
	$(info ** Updating pma Dataset **)
	R $(r_opts) "source('$<')"

# Make all documentation
document: README.md $(documentation)

# Individual documentation
README.md: README.Rmd
	$(info ** Updating README **)
	R $(r_opts) "devtools::build_readme()"

$(documentation): $(scripts) 
	$(info ** Updating Documentation **)
	R $(r_opts) "devtools::document()"

# Install
install: data document 
	$(info ** Installing Package **)
	R $(r_opts) "devtools::install(upgrade = TRUE)"
