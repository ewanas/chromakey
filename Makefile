SKETCH = chromakey
sketchbook = $(shell cat $$HOME/.processing/preferences.txt | grep "sketchbook" | cut -d= -f2)

.PHONY: run

run: $(SKETCH).pde
	processing-java --sketch=$(sketchbook)/$(SKETCH) --output=$$HOME/tmp --force --run
