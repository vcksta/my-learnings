# Start with loading all necessary libraries
import numpy as np
import pandas as pd
from os import path
from PIL import Image
from wordcloud import WordCloud, STOPWORDS, ImageColorGenerator

import matplotlib.pyplot as plt
# % matplotlib inline
import warnings
warnings.filterwarnings("ignore")
import random


df = pd.read_csv("winemag-data-130k-v2.csv", index_col=0)

print("There are {} observations and {} features in this dataset. \n".format(df.shape[0],df.shape[1]))
print("There are {} types of wine in this dataset such as {}... \n".format(len(df.variety.unique()), ", ".join(df.variety.unique()[0:5])))
print("There are {} countries producing wine in this dataset such as {}...\n".format(len(df.country.unique()), ", ".join(df.country.unique()[0:5])))
print(df[["country", "description", "points"]])

country = df.groupby("country").max(numeric_only=True)

country.describe().head()


#start with one review:
text= df.description[0]
print(text)

wordcloud = WordCloud(max_font_size=50, max_words=100,
background_color="white").generate(text)

wordcloud.to_file("graphics/img/first_review.png")

text = " ".join(review for review in df.description)
print("There are {} words in the combination of all review.".format(len(text)))

stopwords = set(STOPWORDS)
stopwords.update(["drink","now","wine","flavor","flavors"])

wordcloud = WordCloud(stopwords=stopwords, background_color="white").generate(text)

wine_mask = np.array(Image.open("graphics/img/wine_mask.png"))
wine_mask

"graphics/img/wine_mask.png"
wine_mask = np.array(Image.open("graphics/img/wine_mask.png"))
wine_mask


def transform_format(val):
    if val == 0:
        return 255
    else:
        return val

transformed_wine_mask = np.ndarray((wine_mask.shape[0],wine_mask.shape[1]), np.int32)

for i in range(len(wine_mask)):
    transformed_wine_mask[i] = list(map(transform_format, wine_mask[i]))

transformed_wine_mask

wc = WordCloud(background_color = "white", max_words=1000, mask=transformed_wine_mask,
stopwords=stopwords, contour_width=3, contour_color='firebrick')

#generating a wrodcloud
wc.generate(text)

#store to file
wc.to_file("graphics/img/wine.png")

#show

plt.figure(figsize=[20,10])
plt.imshow(wc, interpolation='bilinear')
plt.axis("off")
plt.show()

country = df['country'].value_counts()
country.sort_values(ascending=False).head()


# Join all reviews of each country:
usa = " ".join(review for review in df[df["country"]=="US"].description)
fra = " ".join(review for review in df[df["country"]=="France"].description)
ita = " ".join(review for review in df[df["country"]=="Italy"].description)
spa = " ".join(review for review in df[df["country"]=="Spain"].description)
por = " ".join(review for review in df[df["country"]=="Portugal"].description)

# Generate a word cloud image
mask = np.array(Image.open("graphics/img/us.png"))
wordcloud_usa = WordCloud(stopwords=stopwords, background_color="white", mode="RGBA", max_words=1000, mask=mask).generate(usa)

#create coloring from image
image_colors = ImageColorGenerator(mask)
plt.figure(figsize=[7,7])
plt.imshow(wordcloud_usa.recolor(color_func=image_colors), interpolation="bilinear")
plt.axis("off")

# store to file
plt.savefig("graphics/img/us_wine.png", format="png")

plt.show()
