# World Happiness Report 2018 :books:


## **Summary**

The World Happiness Report is an initiative to track global happiness. It is done by a group of independent experts using the data provided by the yearly Gallup World Poll. 

This happiness index is created using six major areas that have been found to support well-being: income, perception of corruption, generosity and trust, social support, life expectancy and freedom to make your own life choices.

Another key point of the data set is the focus on migration and the happiness of immigrants. The database has two variables that show how the happiness index from locals and immigrants differ

In the following data visualization we explore how happiness changes and the ongoing trends between different countries, while keeping an eye out for the differences between locals and immigrants.

[Tableau Story - Before feedback](https://public.tableau.com/profile/julius.verne#!/vizhome/WorldHappinessReport2018/Historia1)

[Tableau Story - After feedback](https://public.tableau.com/views/WorldHappinessReport2018-Feedback/Historia1?:embed=y&:display_count=yes&publish=yes) 



![Photo by Alejandro Alvarez on Unsplash](https://d2mxuefqeaa7sj.cloudfront.net/s_BED08A47A13C2C4AA729AED41EA3569AE67D84CFB8AE2B92E486307D081DC1A0_1523914015964_alejandro-alvarez-150148-unsplash.jpg)



## **Design**

In order to easily explore the data set using Tableau we need to clean and simplify the data gathered. My main goal during the data wrangling process was to simplify the exploratory data analysis process by deleting irrelevant columns and finding mistakes in the data.


---


**Data Wrangling**

Gather
All the data was taken from the [World Happiness Report 2018](http://worldhappiness.report/ed/2018/) website. 
The wrangling process is done using **R** in order to read and clean the .xls file.

Assess

- Changes **time_data**:
  - Delete GINI index (World Bank estimate) due to a high number of NULL values
  - Delete GINI index (World Bank estimate), average 2000-15 due to NULL values
  - Change year to a Date variable
  - Drop all the "Standard deviation" columns


- Changes **happiness_data**:
  - Drop all the x__1 - x__13 variables.
  - Drop Whisker-high & Whisker-low
  - Rename variables for readability


- Changes **happiness_change**
  - Calculate the old Happiness Index Value using amount it has changed.
  - Rename Change in happiness score as "Happiness_Change"
  - Drop Whisker-high & Whisker-low
  - After cleaning, Join with happiness_data


- Changes **migrant_data:**
  - Drop Whisker-high & Whisker-low
  - After cleaning, Join with happiness_data


- Changes **country_data:**
  - Drop all the "Standard error" columns
  - Rename variables for readability
  - After cleaning, Join with happiness_data


- Changes to the new **happiness_data**
  - Drop Djibouti, Omar and Comoros due to NULL values
  - Join North Cyprus to Northern Cyprus 
  - Join Hong Kong S.A.R. of China and Hong Kong SAR, China
  - Join Somalia & Somali land 
  - Join Trinidad & Tobago with Trinidad and Tobago 


---

**Data Dictionary**

The wrangling process ended up with two files, TIME_DATA and HAPPINESS_DATA:



| **TIME_DATA**                     |        |                                                                                                                                                                                                                                                                                                                                                                                                                         |
| --------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Country                           | String | Country Name                                                                                                                                                                                                                                                                                                                                                                                                            |
| Year                              | Date   | Year the Record was taken                                                                                                                                                                                                                                                                                                                                                                                               |
| Life Ladder                       | Float  | National AVG response to the questions: *“Please imagine a ladder, with steps numbered from 0 at the bottom to 10 at the top. The top of the ladder represents the best possible life for you and the bottom of the ladder represents the worst possible life for you. On which step of the ladder would you say you personally feel you stand at this time?”*. This measure is also know as the *Candrill Life Ladder* |
| Log GDP per Capita                | Float  | Natural log of GPD per Capita                                                                                                                                                                                                                                                                                                                                                                                           |
| Social Support                    | Float  | National AVG of the responses to the GWP question *“If you were in trouble, do you have relatives or friends you can count on to help you whenever you need them, or not?”*                                                                                                                                                                                                                                             |
| Healthy Life Expectancy           | Float  | Life Expectancy AVG based on data by the WHO and the WDI                                                                                                                                                                                                                                                                                                                                                                |
| Freedom to make life choices      | Float  | National AVG of responses to the GWP question *“Are you satisfied or dissatisfied with your freedom to choose what you do with your life?”*                                                                                                                                                                                                                                                                             |
| Generosity                        | Float  | Residual of regressing national AVG of response to the GWP question *“Have you donated money to a charity in the past month?”* on GPD per Capita                                                                                                                                                                                                                                                                        |
| Positive Affect                   | Float  | AVG of three positive affect measures in GWP: *happiness, laugh and enjoyment*                                                                                                                                                                                                                                                                                                                                          |
| Negative Affect                   | Float  | AVG of three negative affect measures in GWP: *worry, sadness and anger*                                                                                                                                                                                                                                                                                                                                                |
| Confidence in National Government | Float  | National AVG of responses to the GWP question: *“Do you have confidence in each of the following, or not? How about the national government?*                                                                                                                                                                                                                                                                           |
| Democratic Quality                | Float  | Measures of governance are based on Worldwide Governance Indicators: *Voice and Accountability, Political Stability and Absence of Violence.*                                                                                                                                                                                                                                                                           |
| Delivery Quality                  | Float  | Measures of governance are based on Worldwide Governance Indicators: *Government Effectiveness, Regulatory Quality, Rule of Law, Control of Corruption*                                                                                                                                                                                                                                                                 |
| GINI Household Income             | Float  | Measure of inequality using household income as a base                                                                                                                                                                                                                                                                                                                                                                  |


---


| **HAPPINESS_DATA**                                           |        |                                                                                                                        |
| ------------------------------------------------------------ | ------ | ---------------------------------------------------------------------------------------------------------------------- |
| Country                                                      | String | Name of the Country                                                                                                    |
| AVG Happiness Foreign                                        | Float  | Avg. Happiness of inmigrants in a country                                                                              |
| AVG Happiness Local                                          | Float  | Avg. Happiness of locals in a country                                                                                  |
| Happiness Index 2018                                         | Float  | Happiness index for the year 2018                                                                                      |
| Dystopia Compared                                            | Float  | How well a country indexes are whent compared to an hypothetical country *Dystopia* with the worst indexes.            |
| Explained: GDP  Per Capita                                   | Float  | Amount of Happiness Index Explained by GDP per Capita                                                                  |
| Explained: Social Supp                                       | Float  | Amount of Happiness Index Explained by Social Support                                                                  |
| Explained: Life Exp                                          | Float  | Amount of Happiness Index Explained by Life Expectancy                                                                 |
| Explained: Freedom                                           | Float  | Amount of Happiness Index Explained by Freedom                                                                         |
| Explained: Generosity                                        | Float  | Amount of Happiness Index Explained by Generosity                                                                      |
| Explained: Corruption                                        | Float  | Amount of Happiness Index Explained by Perception of Corruption                                                        |
| Happiness Index 2010                                         | Float  | Happiness Index 2010                                                                                                   |
| Region Indicator                                             | String | Region or Group the country belongs to                                                                                 |
| Life ladder, 2015-2017                                       | Float  | Life Ladder for the time period between 2015 - 2017                                                                    |
| Log of GDP per person, 2015-2017                             | Float  | Natural log of GPD per Capita for the time period between 2015 - 2017                                                  |
| GDP per person, 2015-2017                                    | Float  | GPD per Capita for the time period between 2015 - 2017                                                                 |
| Healthy life expectancy, 2015-2017                           | Float  | Life Expectancy for the time period between 2015 - 2017                                                                |
| Social support, 2015-2017                                    | Float  | Social Support for the time period between 2015 - 2017                                                                 |
| Freedom to make life choices, 2015-2017                      | Float  | Freedom to make life choices for the time period between 2015 - 2017                                                   |
| Generosity, 2015-2017, without adjustment for GDP per person | Float  | Generosity for the time period between 2015 - 2017 without adjustment for GDP per person                               |
| Perceptions of corruption, 2015-2017                         | Float  | Perception of Corruption for the time period between 2015 - 2017. The higher the number the more perceived corruption. |


:bookmark: :bookmark:

During the visualization process I created an extra file called slopgraph.csv which has the some of the same variables reorganized to simplify the creation of a slopegraph.

I also transformed the csv files to xlsx files using Excel to avoid some data type issues that where happening with Tableau. Both the csv files and the xlsx files are attached in my submission.

---------------------------------------------------------------------------------------------------------------------

**Data Visualization Design** 


One of the things I like to keep in mind when creating visualizations is being clear in the message you want to convey but at the same time leave room to explore and discover insights and little gems that are not the main focus of the analysis.

For the initial exploration of happiness and indexes distribution across regions I decided to use a bar graph as a way to compare the diferent values among the different regions (categorical variables). This allows us to know with just a quick glance who is performing better or worse among the regions.

For the dashboards showing how happiness and happiness change is distributed along the globe I decided to use a map, this allow the user to understand the data in context and see the different geographical pattern more clearly. I also decided to include a beeswarm plot as a way to show the distribution of the respective variable (Happiness or Happiness Change) so the user could find interesting or extreme values more easily. Also in order to help that goal I added a highlight tool which filters the data by country. That way you can find you home town or any place of interest easily.

There is an element of change in the dataset, we have the different happiness values for the year 2010 and the year 2018. I have always thought that slopegraphs are a great way to show the direction and the magnitude of change between values in two different moments. So I decided to go forward with it.

Finally on the last segment I wanted to compare the line graphs between different countries. I decided to use a series of small multiple charts in order to allow people to make easy comparisons and see tendecies the way this countries behaved.

:bar_chart:

![Photo by Cristina Gottardi on Unsplash](https://d2mxuefqeaa7sj.cloudfront.net/s_BED08A47A13C2C4AA729AED41EA3569AE67D84CFB8AE2B92E486307D081DC1A0_1524237748530_cristina-gottardi-285467-unsplash.jpg)




## **Feedback**

I shared the visualization in the Udacity Data Science Slack channel twice. The first one to get feedback from the community itself, the second one during Open hours to get some feedback from the instructors. Here are the results

**Sharing my work:**

:rocket: 
Community Feedback:

I shared my story on April 19th and got feedback by a student named Stuart Wilson ( @tuzgai ). He pointed out the following improvements:


- Saw a couple typos, be sure to spellcheck your work.
- Your explanatory text was good, but I wish it weren't presented as tiny text in a menu box.
- With the number of regions represented, the legend wasn't as useful as it could be. It would be nice if the bars on the bar graphs were individually labelled.

:angel: 
Instructor Feedback:

I shared my story on April 20th and got feedback by an instructor named Mike Yi (@tuzgai). He pointed out the following improvements:


- **Introduction:** The word “the” is cut off for me in the first paragraph.
- **Happiness**: The two plots are slightly redundant, as the box plot covers the same information as the bar chart, and more. Might be better to convey the data as a horizontal box plot (regions on y-axis, happiness on x-axis), with a vertical line for the overall median. As a horizontal bar chart, you can also get rid of the colors and just label the regions on the y-axis.
- **Indices**: Region Highlight works well for pulling individual regions out of the plots, but “Sub-Saharan Africa”’s color is already so desaturated that the highlight doesn’t really work for that region. The sorting for ‘corruption’ needs to be reversed since it is the one scale where higher scores are worse, in order to better show the correlation in metrics across regions. Otherwise it’s confusing for, say, Western Europe to be near the top in all of the subplots except for one of them.
- **Happiness Map**: The legend is slightly redundant with the jittered strip plot and in fact is slightly misleading. The legend suggests 2 and 8 to be the min and max values, respectively, but the strip plot shows that these values aren’t reached, especially on the low end. The legend also suggests that the median break point is at 5, when the strip plot shows it is somewhere around 5.27, a somewhat odd value. I wonder if just showing a histogram instead of a strip plot will work better?
- **Top 5 Gains / Losses**: Make it clear that you are exploring the top 5 positive and negative changes in the second half of your report. There are three countries missing from the “GDP” comparison. Using color to indicate the countries with positive change against those with negative change is okay, but consider other ways of organizing the plots. Put all the negative change countries on one side, and positive changes on the other side. Alternatively, just have two subplots: one for negative change countries, and the other for positive change countries.

---

**Changes**

After hearing the feedback about possible improvements or issues I decided to take action:

:rocket: In order to address Stuart Wilson’s feedback:

- Added reference lines to the graphs so they are more easy to read.
- Cleaned the tags in the first slopegraph
- Uncluttered the text on the story boxes
- Spell Checked the whole story using Grammarly

:angel:  In order to address Mike Yi’s feedback:

- **Introduction:**
  - Double checked the text and the distribution. I also made the container a little bit more larger so it could fit the text more easily.
- **Happiness:**
  - I agree with the instructor, the two charts are a little redundant. I deleted the box plot and gave the bar chart more room to breath.
  - I decided not to drop the colors to mantain consistency, the same colors are used in the following plot and keeping them allows the reader to establish a link between them more easily.
  - Used different colors to avoid regions blending into the background.
  - Corrected the “Perception of Corruption” variable so it show the countries with the largest trust first instead of the ones with the largest perceived corruption. Renamed the graph “Trust in Government”.
- **Indices:**
  - Removed the legend to avoid redundancy and confusion.
  - I decided not to use a histogram and keep the beeswarm plot because a histogram would group the values in bins, this would clean the graph a little but my main goal with the beeswarm is for people to search their country and find where it is located using the hover capabilities of Tableau. For example using a histogram you couldn’t know that Finland is the most happy country or that Burundi is the least happy one.
- **Top 5 Gains / Losses:**
  - Added a subtitle that states clearly that you are looking at the countries with the largest positive or negative happiness growth.
  - I tried the positive and negative split but many of the lines overlapped and it ended up being confusing and hard to read. I decided to stay with the small multiples chart.

**Tableau Stories**


- [Before feedback](https://public.tableau.com/profile/julius.verne#!/vizhome/WorldHappinessReport2018/Historia1)
- [After feedback](https://public.tableau.com/views/WorldHappinessReport2018-Feedback/Historia1?:embed=y&:display_count=yes&publish=yes) 


![Photo by João Silas on Unsplash](https://d2mxuefqeaa7sj.cloudfront.net/s_BED08A47A13C2C4AA729AED41EA3569AE67D84CFB8AE2B92E486307D081DC1A0_1524259378628_joao-silas-74207-unsplash.jpg)



## **References**
- [Add jitter to a strip plot - doingdata.com](https://www.doingdata.org/blog/how-to-create-jitter-plot-strip-plot-in-tableau)
[](http://www.vizwiz.com/2016/03/tableau-tip-tuesday-how-to-create-small.html)
- [How to create small multiples with custom rows and columns - vizwiz.com](http://www.vizwiz.com/2016/03/tableau-tip-tuesday-how-to-create-small.html)
- [Slopegraph - vizwiz](http://www.vizwiz.com/2015/01/slopegraphs.html)

--- 

# Thanks for Reading :tada:
