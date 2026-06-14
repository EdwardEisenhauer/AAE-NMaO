BUILD_DIR  = build
OUT_DIR    = out
REPO_ROOT := $(shell pwd)

DOCKER_IMAGE = latex-builder
LATEX_OPTIONS = -xelatex
#  -interaction=nonstopmode
PACKAGE_NAME = WUSTReport

LAB_DIRS = \
	01_Direct-Methods-for-Solving-Linear-Systems \
	02_Eigenproblems \
	03_Ill-posed-least-squares-problems \
	04_Undetermined-and-constrained-linear-systems \
	05_Iterative-linear-solvers \
	06_Linear-programming \
	07_Unconstrained-Optimization \
	08_Nonlinear-equations

LAB_PDFS  = $(addprefix $(BUILD_DIR)/, $(addsuffix .pdf, $(LAB_DIRS)))
GABOR_PDFS = $(BUILD_DIR)/Gabor_Report_1.pdf $(BUILD_DIR)/Gabor_Report_2.pdf $(BUILD_DIR)/Gabor_Report_3.pdf
PRESENTATION_PDF = $(BUILD_DIR)/Project-Presentation.pdf
PROJECT_REPORT_PDF = $(BUILD_DIR)/Project-Report.pdf
EXAM_PDF = $(BUILD_DIR)/Exam.pdf
PDFBUILDS  = $(LAB_PDFS) $(GABOR_PDFS) $(PRESENTATION_PDF) $(PROJECT_REPORT_PDF) $(EXAM_PDF)


.DEFAULT_GOAL := all


clean :
	-rm -r $(BUILD_DIR) $(OUT_DIR) $(PACKAGE_NAME).sty
.PHONY : clean


all : $(PDFBUILDS)
.PHONY : all


sty : $(PACKAGE_NAME).sty
.PHONY : sty
$(PACKAGE_NAME).sty : $(PACKAGE_NAME).ins $(PACKAGE_NAME).dtx
	mkdir -p $(BUILD_DIR)
	yes | latex -output-directory=$(BUILD_DIR) $(PACKAGE_NAME).ins
	cp $(BUILD_DIR)/$@ $@


.SECONDEXPANSION:
$(LAB_PDFS) : $(BUILD_DIR)/%.pdf: $(PACKAGE_NAME).sty \
	$$(wildcard \
		$$*/Report/main.tex \
		$$*/Report/bibliography.bib \
		$$*/Report/problems/*.tex \
		$$*/Report/problems/*.m \
		$$*/Report/algorithms/*.tex \
		$$*/Report/algorithms/*.m \
		$$*/Report/images/*)
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	cp logo-pwr-2016.pdf $(BUILD_DIR)/
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=$* \
		-output-directory=$(REPO_ROOT)/$(BUILD_DIR) \
		$*/Report/main
	cp $(BUILD_DIR)/$*.pdf $(OUT_DIR)/$*.pdf


# MATLAB-generated figures
build/08_Nonlinear-equations.pdf: \
	08_Nonlinear-equations/Report/images/Contour_Problem1.png \
	08_Nonlinear-equations/Report/images/Contour_Problem2.png \
	08_Nonlinear-equations/Report/images/Iter_Problem3.png

08_Nonlinear-equations/Report/images/Contour_Problem1.png: 08_Nonlinear-equations/Report/problems/Problem_1.m
	mkdir -p 08_Nonlinear-equations/Report/images
	cd 08_Nonlinear-equations/Report && matlab -batch "run('problems/Problem_1.m')"

08_Nonlinear-equations/Report/images/Contour_Problem2.png: 08_Nonlinear-equations/Report/problems/Problem_2.m
	mkdir -p 08_Nonlinear-equations/Report/images
	cd 08_Nonlinear-equations/Report && matlab -batch "run('problems/Problem_2.m')"

08_Nonlinear-equations/Report/images/Iter_Problem3.png: 08_Nonlinear-equations/Report/problems/Problem_3.m
	mkdir -p 08_Nonlinear-equations/Report/images
	cd 08_Nonlinear-equations/Report && matlab -batch "run('problems/Problem_3.m')"


$(BUILD_DIR)/Gabor_Report_1.pdf : $(PACKAGE_NAME).sty Gabor_Report_1/main.tex
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	cp logo-pwr-2016.pdf $(BUILD_DIR)/
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Gabor_Report_1 \
		-output-directory=$(REPO_ROOT)/$(BUILD_DIR) \
		Gabor_Report_1/main
	cp $(BUILD_DIR)/Gabor_Report_1.pdf $(OUT_DIR)/Gabor_Report_1.pdf


NEWPWR_DEPS = $(wildcard Project/beamer*NewPwr.sty) \
              Project/slajd-en.png Project/tyt-en.png Project/Hr_p3.pdf

$(PRESENTATION_PDF) : Project/presentation.tex $(NEWPWR_DEPS)
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Project-Presentation \
		-output-directory=$(REPO_ROOT)/$(BUILD_DIR) \
		Project/presentation
	cp $(BUILD_DIR)/Project-Presentation.pdf $(OUT_DIR)/Project-Presentation.pdf


PROJECT_REPORT_DEPS = $(wildcard \
	Project/Report/sections/*.tex \
	Project/out_weighted.m \
	Project/out_lexicographic.m \
	Project/figures/*.pdf)

$(PROJECT_REPORT_PDF) : $(PACKAGE_NAME).sty Project/Report/main.tex $(PROJECT_REPORT_DEPS)
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	cp $(PACKAGE_NAME).sty Project/Report/
	cp logo-pwr-2016.pdf Project/Report/
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Project-Report \
		-output-directory=$(REPO_ROOT)/$(BUILD_DIR) \
		Project/Report/main
	cp $(BUILD_DIR)/Project-Report.pdf $(OUT_DIR)/Project-Report.pdf


$(BUILD_DIR)/Gabor_Report_2.pdf : $(PACKAGE_NAME).sty Gabor_Report_2/main.tex
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	cp logo-pwr-2016.pdf $(BUILD_DIR)/
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Gabor_Report_2 \
		-output-directory=$(REPO_ROOT)/$(BUILD_DIR) \
		Gabor_Report_2/main
	cp $(BUILD_DIR)/Gabor_Report_2.pdf $(OUT_DIR)/Gabor_Report_2.pdf


$(EXAM_PDF) : Exam/main.tex Exam/01_direct_methods.tex Exam/02_eigenproblems.tex Exam/bibliography.bib
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Exam \
		-output-directory=$(REPO_ROOT)/$(BUILD_DIR) \
		Exam/main
	cp $(BUILD_DIR)/Exam.pdf $(OUT_DIR)/Exam.pdf


$(BUILD_DIR)/Gabor_Report_3.pdf : $(PACKAGE_NAME).sty Gabor_Report_3/main.tex \
	08_Nonlinear-equations/Report/images/Contour_Problem1.png \
	08_Nonlinear-equations/Report/images/Contour_Problem2.png \
	08_Nonlinear-equations/Report/images/Iter_Problem3.png
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	cp logo-pwr-2016.pdf $(BUILD_DIR)/
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Gabor_Report_3 \
		-output-directory=$(REPO_ROOT)/$(BUILD_DIR) \
		Gabor_Report_3/main
	cp $(BUILD_DIR)/Gabor_Report_3.pdf $(OUT_DIR)/Gabor_Report_3.pdf

hadolint : Dockerfile
	docker run --rm --interactive hadolint/hadolint < Dockerfile
.PHONY : hadolint


image : Dockerfile
	docker build \
		--tag $(DOCKER_IMAGE) \
		.
.PHONY : image


docker : image ## Compile the project via the latex-builder docker image
	docker run \
		--rm \
		--interactive \
		--workdir /data \
		--volume `pwd`:/data \
		--name=$(DOCKER_IMAGE) \
		$(DOCKER_IMAGE) \
		sh -c "make all"
.PHONY : docker
