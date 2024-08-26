all:
	$(MAKE) docs
	$(MAKE) nodocs
	$(MAKE) useruffnodocs
	$(MAKE) useruffdocs
clean:
	rm -rf cool-example .copier-answers.yml
setup-env:
	echo '{"add_docs":true,"author":"Bryan Hu","email":"bryan.hu.2020@gmail.com","is_app":true,"module_name":"cool_example","project_description":"Example description.","project_name":"Cool Example","pypi_name":"cool-example","username":"ThatXliner"}' > .copier-answers.yml
run:
	cd cool-example && poetry install && poetry update && poetry lock
docs: clean
	$(MAKE) setup-env
	copier copy . . -a .copier-answers.yml --defaults -d add_docs=true --vcs-ref HEAD -w
	$(MAKE) run
	$(MAKE) clean
nodocs: clean
	$(MAKE) setup-env
	copier copy . . -a .copier-answers.yml --defaults -d add_docs=false  --vcs-ref HEAD -w

mitlicense: clean
	$(MAKE) setup-env
	copier copy . . -a .copier-answers.yml --defaults -d add_docs=false -d license=mit  --vcs-ref HEAD -w
	$(MAKE) run
	$(MAKE) clean
gnulicense: clean
	$(MAKE) setup-env
	copier copy . . -a .copier-answers.yml --defaults -d add_docs=false -d license=gnu  --vcs-ref HEAD -w

useruffnodocs: clean
	$(MAKE) setup-env
	copier copy . . -a .copier-answers.yml --defaults -d add_docs=false -d use_ruff=true --vcs-ref HEAD 
	$(MAKE) run
	$(MAKE) clean
useruffdocs: clean
	$(MAKE) setup-env
	copier copy . . -a .copier-answers.yml --defaults -d add_docs=true -d use_ruff=true --vcs-ref HEAD 
	$(MAKE) run
	$(MAKE) clean
nopackage: clean
	$(MAKE) setup-env
	copier copy . . -a .copier-answers.yml --defaults -d add_docs=false -d is_py_package=false --vcs-ref HEAD
	$(MAKE) run
	$(MAKE) clean
