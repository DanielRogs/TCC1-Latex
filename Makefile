TARGET = TCC1_DanielDavi.pdf

BIBTEX = bibtex
LATEX = latex
DVIPS = dvips
PS2PDF = ps2pdf

VERSION = 0.1.0

FIXOS_DIR = fixos
FIXOS_SOURCES = informacoes.tex fichaCatalografica.tex \
		folhaDeAprovacao.tex pacotes.tex comandos.tex setup.tex	\
		listasAutomaticas.tex indiceAutomatico.tex

FIXOS_FILES = $(addprefix $(FIXOS_DIR)/, $(FIXOS_SOURCES))

EDITAVEIS_DIR = editaveis
EDITAVEIS_SOURCES = informacoes.tex errata.tex dedicatoria.tex \
					agradecimentos.tex epigrafe.tex resumo.tex abstract.tex \
					abreviaturas.tex simbolos.tex introducao.tex \
					aspectosgerais.tex consideracoes.tex textoepostexto.tex \
					elementosdotexto.tex elementosdopostexto.tex \
					apendices.tex anexos.tex

EDITAVEIS_FILES = $(addprefix $(EDITAVEIS_DIR)/, $(EDITAVEIS_SOURCES))

MAIN_FILE = tcc.tex
DVI_FILE  = $(addsuffix .dvi, $(basename $(MAIN_FILE)))
AUX_FILE  = $(addsuffix .aux, $(basename $(MAIN_FILE)))
PS_FILE   = $(addsuffix .ps, $(basename $(MAIN_FILE)))
PDF_FILE  = $(addsuffix .pdf, $(basename $(MAIN_FILE)))

BUILD_DIR = build
JUNK_EXTS = *.log *.bbl *.blg *.brf *.toc *.lof *.lot *.idx *.ilg *.ind *.out *.out.ps

SOURCES = $(FIXOS_FILES) $(EDITAVEIS_FILES)

.PHONY: all clean dist-clean watch
	
all:
	@make $(TARGET)

$(TARGET): $(MAIN_FILE) bibliografia.bib
	latexmk -pdf -synctex=1 -interaction=nonstopmode -file-line-error $(MAIN_FILE)

clean:
	latexmk -c $(MAIN_FILE)
	rm -rf $(BUILD_DIR)
	rm -f *~ *.backup
	rm -f $(TARGET) tcc.bbl tcc.idx tcc.ind tcc.lof tcc.lot tcc.out tcc.toc tcc.blg tcc.brf tcc.ilg

dist: clean
	tar vczf tcc-fga-latex-$(VERSION).tar.gz *

dist-clean: clean
	rm -f $(TARGET)
