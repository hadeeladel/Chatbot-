function documents = preprocessText(textData)
documents = tokenizedDocument(textData);
documents=lower(documents);
%documents = removeStopWords(documents);
%documents = erasePunctuation(documents);
end