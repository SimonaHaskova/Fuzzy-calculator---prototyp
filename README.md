##Overview

This prototype implements a Fuzzy Calculator designed for assessing the Index of Business Environment Quality (IBEQ) for selected countries. The calculator employs fuzzy logic to handle uncertainty in input data, such as indices from rating agencies, and other complex sociological and psychological factors. This tool can be used by foreign investors to classify countries into risk categories: highly risky, conditionally risky, and non-risky.

The project consists of the fuzzy logic model implementation, written in R, and provides flexibility for modifying membership functions, fuzzy rules, and other parameters to suit different decision-making scenarios.

##Dataset

The input dataset (included in the project) contains country-specific data on three indices:

Index of Corruption Rejection (IOCR)

Index of Economic Stability (IOES)

Index of Political Stability (IOPS)

Each index is scaled between 0 and 100, where 0 is the worst and 100 is the best possible evaluation.

##Example input data (part of the provided dataset):

Country		IOCR	IOES	IOPS

Czech Republic	56	73	88

China		37	52	70

Finland		90	73	86

Netherlands	87	75	85

Norway		89	71	90

Poland		62	69	81

Russia		29	51	52

Greece		46	53	60

Turkey		42	62	71

##Dependencies

To run this project, you need the following R packages:

sets

readxl

You can install them by running:

```

install.packages("sets")

install.packages("readxl")

```

##How to Run

1. Clone the repository and open the project directory:

```

git clone https://github.com/SimonaHaskova/Fuzzy-calculator---prototyp

cd Fuzzy-calculator---prototyp

```

Or you can download ZIP file from the site.

2. Open the provided R script (Main.R) in RStudio or your preferred R environment.

3. Load the input data:

```

Input_data <- read_excel("Input data.xlsx")

```

4. Define fuzzy variables and inference rules (already included in the script).

5. Run the Fuzzy Calculator by executing the script. This will read the input data, calculate the IBEQ values, and  classify countries.

6. Output results are saved to Results.csv.

##Customization

You can modify various parameters in the code to explore different scenarios:

Membership Functions: Adjust the shape of the membership functions (e.g., trapezoidal or triangular).

Inference Rules: Modify the fuzzy inference rules to suit different risk criteria.

##Example Output

The output of the Fuzzy Calculator will be the IBEQ values for each country, which can then be used to classify them into the specified risk categories:

Country		IBEQ (%)

Czech Republic	68

China		50

Finland		83

Netherlands	84

Norway		83

Poland		61

Russia		50

Greece		50

Turkey		53


###License

This project is licensed under the MIT License. See the LICENSE file for more details.
