TARGET = TCC_FGA.pdf

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

.PHONY: all clean dist-clean

all:
	@make $(TARGET)

$(TARGET): $(MAIN_FILE) $(SOURCES) bibliografia.bib
	$(LATEX) $(MAIN_FILE) $(SOURCES)
	$(BIBTEX) $(AUX_FILE)
	$(LATEX) $(MAIN_FILE) $(SOURCES)
	$(LATEX) $(MAIN_FILE) $(SOURCES)
	$(DVIPS) $(DVI_FILE)
	$(PS2PDF) $(PS_FILE)
	@cp $(PDF_FILE) $(TARGET)
	@mkdir -p $(BUILD_DIR)
	@mv -f $(AUX_FILE) $(DVI_FILE) $(PS_FILE) $(PDF_FILE) $(BUILD_DIR)/ 2>/dev/null || true
	@mv -f $(JUNK_EXTS) $(BUILD_DIR)/ 2>/dev/null || true

clean:
	rm -rf $(BUILD_DIR)
	rm -f *~ *.backup

dist: clean
	tar vczf tcc-fga-latex-$(VERSION).tar.gz *

dist-clean: clean
	rm -f $(TARGET)
