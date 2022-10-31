.PHONY: clean

objects :=\
	data/greeting.rds\
	plots/example.pdf\
	tables/example.txt

all: $(objects)

clean:
	rm -rf $(objects)

data/greeting.rds:\
	scripts/utils/sayHello.R\
	scripts/processing/makeGreeting.R
		mkdir -p data
		Rscript scripts/processing/makeGreeting.R

plots/example.pdf\
tables/example.txt:\
	scripts/utils/sayHello.R\
	data/greeting.rds\
	scripts/analysis/example.R
		mkdir -p plots tables
		Rscript scripts/analysis/example.R
		