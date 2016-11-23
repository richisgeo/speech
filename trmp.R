library(tm)


url <- "http://textuploader.com/5ffsb"
speech.rawa <- readLines("trump.txt",encoding="UTF-8")
typeof(speech.rawa)
speech.rawa



# library(wordcloud)
 wordcloud(speech.rawa) # Also takes other arguments like color

library(qdap)
library(data.table)
check_text(speech.rawa)
clean(speech.raw)
Encoding(speech.rawa, "ANSI")
warnings()
# Split into sentences
# qdap's sentSplit is modeled after dialogue data, so person field is needed
speech.df <- data.table(speech=speech.rawa, person="trump")
sentences <- data.table(sentSplit(speech.df, "speech"))
# Add a sentence counter and remove unnecessary variables
sentences[, sentence.num := seq(nrow(sentences))]
sentences[, person := NULL]
sentences[, tot := NULL]
setcolorder(sentences, c("sentence.num", "speech"))

sentences[, syllables := syllable_sum(speech)]

sentences[, syllables.cumsum := cumsum(syllables)]
sentences[, pct.complete := syllables.cumsum / sum(sentences$syllables)]
sentences[, pct.complete.100 := pct.complete * 100]



pol.df <- polarity(sentences$speech)$all
sentences[, words := pol.df$wc]
sentences[, pol := pol.df$polarity]


with(sentences, plot(pct.complete, pol))

syllable_count("Insana")
ls(package:qdap)
