import nltk
import re
import pandas as pd

from scipy.sparse import csr_matrix
from typing import List


class Preprocess:
    """
    Preprocessing input text
    """
    def __init__(self, text: str) -> None:
        self.text = text
        self.text_preprocess()
    
    def text_preprocess(self) -> None:
        """
        Preprocesses the text
        """
        # tokenize
        self.text = nltk.tokenize.word_tokenize(self.text)

        # keep alphabets only
        self.text = [re.sub(r"[^A-Za-z]", "", token.lower()) for token in self.text]

        # remove stopwords
        stopwords = nltk.corpus.stopwords.words('english')
        stopwords = [token.lower() for token in stopwords]
        self.text = [token for token in self.text if token not in stopwords and token != '']

        # lemmatize
        lem = nltk.stem.WordNetLemmatizer()
        self.text = [lem.lemmatize(token) for token in self.text]
    
    def process_as_string(self) -> str:
        """
        Return data as string
        """
        return ' '.join(self.text)
    
    def process_as_list(self) -> List[str]:
        """
        Return text as list of texts
        """
        return self.text