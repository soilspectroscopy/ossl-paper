OSSL paper analysis
================

- <a href="#overview" id="toc-overview">Overview</a>
- <a href="#descriptive-analysis"
  id="toc-descriptive-analysis">Descriptive analysis</a>

## Overview

Analysis code fore generating outputs for the OSSL paper.

The workspace development is defined by:

- GitHub repository:
  [whrc/ossl-paper](https://github.com/whrc/ossl-paper)

## Descriptive analysis

Number of unique samples correctly imported into the OSSL per original
source and spectra type.

| dataset.code_ascii_txt | visnir |   mir |  nir |
|:-----------------------|-------:|------:|-----:|
| ICRAF.ISRIC            |   4073 |  4071 |   NA |
| KSSL.SSL               |  19807 | 76813 |   NA |
| LUCAS.SSL              |  40175 |    NA |   NA |
| LUCAS.WOODWELL.SSL     |    589 |   589 |   NA |
| AFSIS1.SSL             |     NA |  1904 |   NA |
| AFSIS2.SSL             |     NA |   151 |   NA |
| CAF.SSL                |     NA |  1578 |   NA |
| GARRETT.SSL            |     NA |   184 |   NA |
| SCHIEDUNG.SSL          |     NA |   259 |   NA |
| SERBIA.SSL             |     NA |   135 |   NA |
| NEOSPECTRA             |     NA |    NA | 2106 |

Number of available samples for selected soil properties per spectra
type and database subset.

| soil_property                  | description                                         | KSSL_VisNIR | KSSL_MIR | OSSL_VisNIR | OSSL_NIR | OSSL_MIR |
|:-------------------------------|:----------------------------------------------------|------------:|---------:|------------:|---------:|---------:|
| acidity_usda.a795_cmolc.kg     | Acidity, BaCl2-TEA Extractable, pH 8.2              |           0 |    28550 |        1511 |     1576 |    30061 |
| aggstb_usda.a1_w.pct           | Aggregate Stability                                 |           0 |     3218 |           0 |      197 |     3218 |
| al.dith_usda.a65_w.pct         | Aluminum, Crystalline, Total Pedogenic Iron         |           0 |    31135 |           0 |     1773 |    31135 |
| al.ext_usda.a1056_mg.kg        | Aluminum, Extractable, Mehlich3                     |           0 |     1534 |           0 |       76 |     3773 |
| al.ext_usda.a69_cmolc.kg       | Aluminum, Extractable, KCl                          |           0 |    14169 |        1541 |      716 |    15710 |
| al.ox_usda.a59_w.pct           | Aluminum, Amorphous, Total Non-Crystalline Iron     |           0 |    28260 |           0 |     1354 |    28260 |
| awc.33.1500kPa_usda.c80_w.frac | Available Water Content, Difference 33-1500 kPa     |           0 |    16175 |           0 |      931 |    16175 |
| b.ext_mel3_mg.kg               | Boron, Extractable, Mehlich3                        |           0 |        0 |           0 |        0 |     2093 |
| bd_usda.a4_g.cm3               | Bulk Density, \<2mm fraction, Clod                  |       19752 |    40136 |       20751 |     1085 |    41484 |
| c.tot_usda.a622_w.pct          | Carbon, Total NCS                                   |       19807 |    76595 |       19807 |     1976 |    80698 |
| ca.ext_usda.a1059_mg.kg        | Calcium, Extractable, Mehlich3                      |           0 |     1534 |           0 |       76 |     3773 |
| ca.ext_usda.a722_cmolc.kg      | Calcium, Extractable, NH4OAc                        |          51 |    53232 |        3723 |     1976 |    57085 |
| caco3_usda.a54_w.pct           | Carbonate, \<2mm Fraction                           |        9213 |    27476 |       51094 |      665 |    29225 |
| cec_usda.a723_cmolc.kg         | CEC, pH 7.0, NH4OAc, 2M KCl displacement            |          51 |    53227 |       22687 |     1976 |    57651 |
| cf_usda.c236_w.pct             | Coarse Fragments, Greater 2mm                       |           0 |    55881 |       23237 |     1969 |    56470 |
| clay.tot_usda.a334_w.pct       | Clay                                                |         166 |    50007 |       27145 |     1976 |    57268 |
| cu.ext_usda.a1063_mg.kg        | Copper, Extractable, Mehlich3                       |           0 |     1534 |           0 |       76 |     3772 |
| ec_usda.a364_ds.m              | Electrical Conductivity, (w/w)                      |          51 |    31886 |       21833 |      942 |    34040 |
| efferv_usda.a479_class         | Effervescense, 1N HCl                               |       19800 |    74016 |       19800 |     1973 |    74016 |
| fe.dith_usda.a66_w.pct         | Iron, Crystalline, Total Pedogenic Iron             |           0 |    31138 |           0 |     1773 |    31138 |
| fe.ext_usda.a1064_mg.kg        | Iron, Extractable, Mehlich3                         |           0 |     1534 |           0 |       76 |     3773 |
| fe.ox_usda.a60_w.pct           | Iron, Amorphous, Total Non-Crystalline Iron         |           0 |    28259 |           0 |     1354 |    28259 |
| k.ext_usda.a1065_mg.kg         | Potassium, Extractable, Mehlich3                    |           0 |     1534 |           0 |       76 |     3772 |
| k.ext_usda.a725_cmolc.kg       | Potassium, Extractable, NH4OAc, 2M KCl displacement |          51 |    53230 |       44489 |     1976 |    57674 |
| mg.ext_usda.a1066_mg.kg        | Magnesium, Extractable, Mehlich3                    |           0 |     1534 |           0 |       76 |     3773 |
| mg.ext_usda.a724_cmolc.kg      | Magnesium, Extractable, NH4OAc, 2M KCl displacement |          51 |    53232 |        3731 |     1976 |    57093 |
| mn.ext_usda.a1067_mg.kg        | Manganese, Extractable, Mehlich3                    |           0 |     1534 |           0 |       76 |     3772 |
| mn.ext_usda.a70_mg.kg          | Manganese, Extractable, KCl                         |           0 |    14166 |           0 |      716 |    14166 |
| n.tot_usda.a623_w.pct          | Nitrogen, Total NCS                                 |       19806 |    76594 |       60570 |     1976 |    81282 |
| na.ext_usda.a1068_mg.kg        | Sodium, Extractable, Mehlich3                       |           0 |     1534 |           0 |       76 |     3616 |
| na.ext_usda.a726_cmolc.kg      | Sodium, Extractable, NH4OAc, 2M KCl displacement    |          51 |    53230 |        3715 |     1976 |    57075 |
| oc_usda.c729_w.pct             | Organic Carbon, Total C without CaCO3, S prep       |       19747 |    75929 |       64211 |     1974 |    82573 |
| p.ext_usda.a1070_mg.kg         | Phosphorus, Extractable, Mehlich3                   |           0 |    25602 |           0 |      754 |    27690 |
| p.ext_usda.a270_mg.kg          | Phosphorus, Extractable, Bray1                      |           0 |     7146 |           0 |      266 |     7282 |
| p.ext_usda.a274_mg.kg          | Phosphorus, Extractable, Olsen                      |           0 |    15359 |       40764 |      281 |    16084 |
| ph.cacl2_usda.a481_index       | pH, 1:2 Soil-CaCl2 Suspension                       |          50 |    52946 |       40848 |     1976 |    53819 |
| ph.h2o_usda.a268_index         | pH, 1:1 Soil-Water Suspension                       |          50 |    52867 |       44590 |     1976 |    59997 |
| s.tot_usda.a624_w.pct          | Sulfur, Total NCS                                   |       19807 |    76592 |       19807 |     1976 |    76592 |
| sand.tot_usda.c60_w.pct        | Sand, Total, S prep                                 |         166 |    50012 |       27086 |     1976 |    57162 |
| silt.tot_usda.c62_w.pct        | Silt, Total, S prep                                 |         166 |    50013 |       27139 |     1976 |    57215 |
| wr.1500kPa_usda.a417_w.pct     | Water Retention, 15 Bar (1500 kPa)                  |           0 |    40284 |         971 |     1951 |    41345 |
| wr.33kPa_usda.a415_w.pct       | Water Retention, 1/3 Bar (33 kPa)                   |           0 |    18536 |         923 |     1032 |    19459 |
| zn.ext_usda.a1073_mg.kg        | Zinc, Extractable, Mehlich3                         |           0 |     1534 |           0 |       76 |     3760 |
