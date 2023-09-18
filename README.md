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
| ICRAF.ISRIC            |   4073 |  4071 |    0 |
| KSSL.SSL               |  19807 | 76813 |    0 |
| LUCAS.SSL              |  40175 |     0 |    0 |
| LUCAS.WOODWELL.SSL     |    589 |   589 |    0 |
| AFSIS1.SSL             |      0 |  1904 |    0 |
| AFSIS2.SSL             |      0 |   151 |    0 |
| CAF.SSL                |      0 |  1578 |    0 |
| GARRETT.SSL            |      0 |   184 |    0 |
| SCHIEDUNG.SSL          |      0 |   259 |    0 |
| SERBIA.SSL             |      0 |   135 |    0 |
| NEOSPECTRA             |      0 |     0 | 2106 |

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

Performance from 10-fold cross-validation

| soil_property                  | model_name                         |   rmse |   bias |   rsq |   ccc |   rpiq |
|:-------------------------------|:-----------------------------------|-------:|-------:|------:|------:|-------:|
| acidity_usda.a795_cmolc.kg     | mir_cubist_kssl_na_v1.2            |  0.262 | -0.006 | 0.927 | 0.962 |  4.378 |
| acidity_usda.a795_cmolc.kg     | mir_cubist_ossl_na_v1.2            |  0.273 | -0.010 | 0.927 | 0.962 |  4.355 |
| acidity_usda.a795_cmolc.kg     | nir.neospectra_cubist_ossl_na_v1.2 |  0.505 | -0.012 | 0.651 | 0.784 |  2.220 |
| acidity_usda.a795_cmolc.kg     | visnir_cubist_ossl_na_v1.2         |  0.424 |  0.018 | 0.652 | 0.771 |  2.593 |
| aggstb_usda.a1_w.pct           | mir_cubist_kssl_na_v1.2            |  0.636 | -0.040 | 0.687 | 0.803 |  2.918 |
| aggstb_usda.a1_w.pct           | mir_cubist_ossl_na_v1.2            |  0.638 | -0.044 | 0.685 | 0.802 |  2.909 |
| al.dith_usda.a65_w.pct         | mir_cubist_kssl_na_v1.2            |  0.055 |  0.002 | 0.909 | 0.951 |  2.701 |
| al.dith_usda.a65_w.pct         | mir_cubist_ossl_na_v1.2            |  0.055 |  0.002 | 0.911 | 0.951 |  2.721 |
| al.dith_usda.a65_w.pct         | nir.neospectra_cubist_ossl_na_v1.2 |  0.085 |  0.004 | 0.741 | 0.837 |  1.485 |
| al.ext_usda.a1056_mg.kg        | mir_cubist_kssl_na_v1.2            |  0.519 | -0.015 | 0.922 | 0.958 |  2.905 |
| al.ext_usda.a1056_mg.kg        | mir_cubist_ossl_na_v1.2            |  0.377 | -0.017 | 0.920 | 0.957 |  2.688 |
| al.ext_usda.a69_cmolc.kg       | mir_cubist_kssl_na_v1.2            |  0.228 | -0.001 | 0.903 | 0.948 |  4.799 |
| al.ext_usda.a69_cmolc.kg       | mir_cubist_ossl_na_v1.2            |  0.233 | -0.002 | 0.898 | 0.945 |  4.744 |
| al.ext_usda.a69_cmolc.kg       | nir.neospectra_cubist_ossl_na_v1.2 |  0.454 |  0.031 | 0.540 | 0.697 |  2.163 |
| al.ext_usda.a69_cmolc.kg       | visnir_cubist_ossl_na_v1.2         |  0.426 |  0.016 | 0.629 | 0.756 |  2.657 |
| al.ox_usda.a59_w.pct           | mir_cubist_kssl_na_v1.2            |  0.058 |  0.003 | 0.942 | 0.969 |  2.598 |
| al.ox_usda.a59_w.pct           | mir_cubist_ossl_na_v1.2            |  0.058 |  0.003 | 0.942 | 0.969 |  2.601 |
| al.ox_usda.a59_w.pct           | nir.neospectra_cubist_ossl_na_v1.2 |  0.104 |  0.005 | 0.770 | 0.855 |  1.168 |
| awc.33.1500kPa_usda.c80_w.frac | mir_cubist_kssl_na_v1.2            |  0.044 |  0.001 | 0.479 | 0.612 |  1.574 |
| awc.33.1500kPa_usda.c80_w.frac | mir_cubist_ossl_na_v1.2            |  0.044 |  0.001 | 0.482 | 0.615 |  1.578 |
| awc.33.1500kPa_usda.c80_w.frac | nir.neospectra_cubist_ossl_na_v1.2 |  0.053 |  0.000 | 0.166 | 0.310 |  1.372 |
| b.ext_mel3_mg.kg               | mir_cubist_ossl_na_v1.2            |  0.165 |  0.006 | 0.800 | 0.875 |  1.648 |
| bd_usda.a4_g.cm3               | mir_cubist_kssl_na_v1.2            |  0.120 | -0.006 | 0.753 | 0.857 |  2.031 |
| bd_usda.a4_g.cm3               | mir_cubist_ossl_na_v1.2            |  0.119 | -0.006 | 0.752 | 0.857 |  2.041 |
| bd_usda.a4_g.cm3               | nir.neospectra_cubist_ossl_na_v1.2 |  0.082 | -0.007 | 0.446 | 0.617 |  1.463 |
| bd_usda.a4_g.cm3               | visnir_cubist_kssl_na_v1.2         |  0.135 | -0.009 | 0.664 | 0.790 |  1.781 |
| bd_usda.a4_g.cm3               | visnir_cubist_ossl_na_v1.2         |  0.132 | -0.009 | 0.670 | 0.793 |  1.794 |
| c.tot_usda.a622_w.pct          | mir_cubist_kssl_na_v1.2            |  0.102 |  0.003 | 0.992 | 0.996 | 12.251 |
| c.tot_usda.a622_w.pct          | mir_cubist_ossl_na_v1.2            |  0.103 |  0.002 | 0.991 | 0.996 | 11.756 |
| c.tot_usda.a622_w.pct          | nir.neospectra_cubist_ossl_na_v1.2 |  0.272 | -0.005 | 0.766 | 0.867 |  2.892 |
| c.tot_usda.a622_w.pct          | visnir_cubist_kssl_na_v1.2         |  0.238 | -0.009 | 0.969 | 0.984 | 10.544 |
| c.tot_usda.a622_w.pct          | visnir_cubist_ossl_na_v1.2         |  0.231 | -0.007 | 0.971 | 0.985 | 10.908 |
| ca.ext_usda.a1059_mg.kg        | mir_cubist_kssl_na_v1.2            |  0.434 | -0.022 | 0.941 | 0.969 |  4.778 |
| ca.ext_usda.a1059_mg.kg        | mir_cubist_ossl_na_v1.2            |  0.413 | -0.020 | 0.937 | 0.966 |  5.355 |
| ca.ext_usda.a722_cmolc.kg      | mir_cubist_kssl_na_v1.2            |  0.270 | -0.010 | 0.957 | 0.977 |  7.034 |
| ca.ext_usda.a722_cmolc.kg      | mir_cubist_ossl_na_v1.2            |  0.278 | -0.012 | 0.955 | 0.977 |  7.014 |
| ca.ext_usda.a722_cmolc.kg      | nir.neospectra_cubist_ossl_na_v1.2 |  0.579 | -0.016 | 0.801 | 0.887 |  3.297 |
| ca.ext_usda.a722_cmolc.kg      | visnir_cubist_ossl_na_v1.2         |  0.505 | -0.007 | 0.853 | 0.915 |  4.847 |
| caco3_usda.a54_w.pct           | mir_cubist_kssl_na_v1.2            |  0.180 | -0.002 | 0.979 | 0.990 | 12.580 |
| caco3_usda.a54_w.pct           | mir_cubist_ossl_na_v1.2            |  0.201 | -0.001 | 0.974 | 0.987 | 11.230 |
| caco3_usda.a54_w.pct           | nir.neospectra_cubist_ossl_na_v1.2 |  0.645 | -0.017 | 0.666 | 0.803 |  3.058 |
| caco3_usda.a54_w.pct           | visnir_cubist_kssl_na_v1.2         |  0.393 |  0.020 | 0.873 | 0.929 |  2.913 |
| caco3_usda.a54_w.pct           | visnir_cubist_ossl_na_v1.2         |  0.360 |  0.006 | 0.914 | 0.954 |  3.141 |
| cec_usda.a723_cmolc.kg         | mir_cubist_kssl_na_v1.2            |  0.158 | -0.003 | 0.969 | 0.984 |  6.680 |
| cec_usda.a723_cmolc.kg         | mir_cubist_ossl_na_v1.2            |  0.175 | -0.004 | 0.961 | 0.980 |  6.116 |
| cec_usda.a723_cmolc.kg         | nir.neospectra_cubist_ossl_na_v1.2 |  0.375 | -0.030 | 0.717 | 0.827 |  2.519 |
| cec_usda.a723_cmolc.kg         | visnir_cubist_ossl_na_v1.2         |  0.345 | -0.020 | 0.798 | 0.881 |  2.940 |
| cf_usda.c236_w.pct             | mir_cubist_kssl_na_v1.2            |  0.894 |  0.051 | 0.589 | 0.717 |  2.327 |
| cf_usda.c236_w.pct             | mir_cubist_ossl_na_v1.2            |  0.902 |  0.052 | 0.582 | 0.713 |  2.306 |
| cf_usda.c236_w.pct             | nir.neospectra_cubist_ossl_na_v1.2 |  1.163 |  0.112 | 0.327 | 0.477 |  2.294 |
| cf_usda.c236_w.pct             | visnir_cubist_ossl_na_v1.2         |  0.666 | -0.041 | 0.331 | 0.473 |  1.650 |
| clay.tot_usda.a334_w.pct       | mir_cubist_kssl_na_v1.2            |  3.953 |  0.022 | 0.941 | 0.968 |  5.688 |
| clay.tot_usda.a334_w.pct       | mir_cubist_ossl_na_v1.2            |  5.639 |  0.104 | 0.898 | 0.945 |  4.200 |
| clay.tot_usda.a334_w.pct       | nir.neospectra_cubist_ossl_na_v1.2 |  7.302 |  0.121 | 0.721 | 0.829 |  2.602 |
| clay.tot_usda.a334_w.pct       | visnir_cubist_ossl_na_v1.2         |  6.611 |  0.273 | 0.818 | 0.894 |  3.025 |
| cu.ext_usda.a1063_mg.kg        | mir_cubist_kssl_na_v1.2            |  0.252 |  0.004 | 0.862 | 0.921 |  4.245 |
| cu.ext_usda.a1063_mg.kg        | mir_cubist_ossl_na_v1.2            |  0.286 |  0.012 | 0.782 | 0.866 |  3.231 |
| ec_usda.a364_ds.m              | mir_cubist_kssl_na_v1.2            |  0.317 |  0.029 | 0.866 | 0.922 |  1.724 |
| ec_usda.a364_ds.m              | mir_cubist_ossl_na_v1.2            |  0.313 |  0.030 | 0.865 | 0.921 |  1.690 |
| ec_usda.a364_ds.m              | nir.neospectra_cubist_ossl_na_v1.2 |  0.362 |  0.058 | 0.545 | 0.653 |  0.700 |
| ec_usda.a364_ds.m              | visnir_cubist_ossl_na_v1.2         |  0.119 |  0.016 | 0.618 | 0.732 |  1.279 |
| fe.dith_usda.a66_w.pct         | mir_cubist_kssl_na_v1.2            |  0.149 |  0.000 | 0.909 | 0.951 |  4.399 |
| fe.dith_usda.a66_w.pct         | mir_cubist_ossl_na_v1.2            |  0.146 |  0.000 | 0.912 | 0.953 |  4.481 |
| fe.dith_usda.a66_w.pct         | nir.neospectra_cubist_ossl_na_v1.2 |  0.248 |  0.000 | 0.621 | 0.753 |  2.147 |
| fe.ext_usda.a1064_mg.kg        | mir_cubist_kssl_na_v1.2            |  0.424 |  0.011 | 0.802 | 0.887 |  2.597 |
| fe.ext_usda.a1064_mg.kg        | mir_cubist_ossl_na_v1.2            |  0.389 |  0.004 | 0.761 | 0.855 |  2.375 |
| fe.ox_usda.a60_w.pct           | mir_cubist_kssl_na_v1.2            |  0.124 |  0.007 | 0.817 | 0.887 |  2.751 |
| fe.ox_usda.a60_w.pct           | mir_cubist_ossl_na_v1.2            |  0.129 |  0.007 | 0.800 | 0.878 |  2.646 |
| fe.ox_usda.a60_w.pct           | nir.neospectra_cubist_ossl_na_v1.2 |  0.155 |  0.012 | 0.578 | 0.698 |  1.753 |
| k.ext_usda.a1065_mg.kg         | mir_cubist_kssl_na_v1.2            |  0.515 | -0.015 | 0.806 | 0.882 |  2.142 |
| k.ext_usda.a1065_mg.kg         | mir_cubist_ossl_na_v1.2            |  0.524 | -0.006 | 0.763 | 0.854 |  2.529 |
| k.ext_usda.a725_cmolc.kg       | mir_cubist_kssl_na_v1.2            |  0.172 |  0.012 | 0.800 | 0.879 |  2.405 |
| k.ext_usda.a725_cmolc.kg       | mir_cubist_ossl_na_v1.2            |  0.175 |  0.014 | 0.793 | 0.872 |  2.358 |
| k.ext_usda.a725_cmolc.kg       | nir.neospectra_cubist_ossl_na_v1.2 |  0.222 |  0.026 | 0.542 | 0.684 |  1.747 |
| k.ext_usda.a725_cmolc.kg       | visnir_cubist_ossl_na_v1.2         |  0.234 |  0.024 | 0.640 | 0.758 |  2.159 |
| mg.ext_usda.a1066_mg.kg        | mir_cubist_kssl_na_v1.2            |  0.467 | -0.024 | 0.895 | 0.943 |  4.448 |
| mg.ext_usda.a1066_mg.kg        | mir_cubist_ossl_na_v1.2            |  0.443 | -0.025 | 0.888 | 0.938 |  4.394 |
| mg.ext_usda.a724_cmolc.kg      | mir_cubist_kssl_na_v1.2            |  0.256 | -0.004 | 0.921 | 0.958 |  5.275 |
| mg.ext_usda.a724_cmolc.kg      | mir_cubist_ossl_na_v1.2            |  0.260 | -0.005 | 0.920 | 0.957 |  5.289 |
| mg.ext_usda.a724_cmolc.kg      | nir.neospectra_cubist_ossl_na_v1.2 |  0.406 |  0.011 | 0.724 | 0.830 |  2.851 |
| mg.ext_usda.a724_cmolc.kg      | visnir_cubist_ossl_na_v1.2         |  0.397 |  0.013 | 0.780 | 0.866 |  3.271 |
| mn.ext_usda.a1067_mg.kg        | mir_cubist_kssl_na_v1.2            |  0.609 | -0.025 | 0.796 | 0.877 |  2.845 |
| mn.ext_usda.a1067_mg.kg        | mir_cubist_ossl_na_v1.2            |  0.676 | -0.033 | 0.760 | 0.848 |  2.737 |
| mn.ext_usda.a70_mg.kg          | mir_cubist_kssl_na_v1.2            |  0.741 |  0.053 | 0.685 | 0.789 |  2.064 |
| mn.ext_usda.a70_mg.kg          | mir_cubist_ossl_na_v1.2            |  0.741 |  0.056 | 0.685 | 0.789 |  2.064 |
| mn.ext_usda.a70_mg.kg          | nir.neospectra_cubist_ossl_na_v1.2 |  0.784 |  0.091 | 0.296 | 0.419 |  1.527 |
| n.tot_usda.a623_w.pct          | mir_cubist_kssl_na_v1.2            |  0.057 |  0.002 | 0.969 | 0.984 |  3.818 |
| n.tot_usda.a623_w.pct          | mir_cubist_ossl_na_v1.2            |  0.056 |  0.002 | 0.969 | 0.984 |  3.622 |
| n.tot_usda.a623_w.pct          | nir.neospectra_cubist_ossl_na_v1.2 |  0.069 |  0.003 | 0.695 | 0.805 |  2.006 |
| n.tot_usda.a623_w.pct          | visnir_cubist_kssl_na_v1.2         |  0.099 |  0.000 | 0.934 | 0.966 |  5.295 |
| n.tot_usda.a623_w.pct          | visnir_cubist_ossl_na_v1.2         |  0.081 |  0.003 | 0.921 | 0.958 |  2.520 |
| na.ext_usda.a1068_mg.kg        | mir_cubist_kssl_na_v1.2            |  0.782 |  0.026 | 0.753 | 0.850 |  2.636 |
| na.ext_usda.a1068_mg.kg        | mir_cubist_ossl_na_v1.2            |  0.716 |  0.022 | 0.677 | 0.789 |  1.657 |
| na.ext_usda.a726_cmolc.kg      | mir_cubist_kssl_na_v1.2            |  0.403 |  0.031 | 0.821 | 0.890 |  0.482 |
| na.ext_usda.a726_cmolc.kg      | mir_cubist_ossl_na_v1.2            |  0.420 |  0.040 | 0.796 | 0.872 |  0.469 |
| na.ext_usda.a726_cmolc.kg      | nir.neospectra_cubist_ossl_na_v1.2 |  0.431 |  0.063 | 0.416 | 0.424 |  0.114 |
| na.ext_usda.a726_cmolc.kg      | visnir_cubist_ossl_na_v1.2         |  0.337 |  0.038 | 0.542 | 0.645 |  0.778 |
| oc_usda.c729_w.pct             | mir_cubist_kssl_na_v1.2            |  0.114 |  0.004 | 0.990 | 0.995 | 11.009 |
| oc_usda.c729_w.pct             | mir_cubist_ossl_na_v1.2            |  0.119 |  0.004 | 0.989 | 0.994 |  9.984 |
| oc_usda.c729_w.pct             | nir.neospectra_cubist_ossl_na_v1.2 |  0.251 | -0.006 | 0.805 | 0.891 |  3.220 |
| oc_usda.c729_w.pct             | visnir_cubist_kssl_na_v1.2         |  0.232 | -0.008 | 0.972 | 0.986 | 11.243 |
| oc_usda.c729_w.pct             | visnir_cubist_ossl_na_v1.2         |  0.236 | -0.001 | 0.945 | 0.971 |  4.202 |
| p.ext_usda.a1070_mg.kg         | mir_cubist_kssl_na_v1.2            |  0.807 |  0.005 | 0.683 | 0.789 |  2.838 |
| p.ext_usda.a1070_mg.kg         | mir_cubist_ossl_na_v1.2            |  0.802 |  0.014 | 0.674 | 0.789 |  2.787 |
| p.ext_usda.a1070_mg.kg         | nir.neospectra_cubist_ossl_na_v1.2 |  1.159 | -0.010 | 0.299 | 0.446 |  1.804 |
| p.ext_usda.a270_mg.kg          | mir_cubist_kssl_na_v1.2            |  0.756 |  0.028 | 0.726 | 0.826 |  3.021 |
| p.ext_usda.a270_mg.kg          | mir_cubist_ossl_na_v1.2            |  0.760 |  0.035 | 0.719 | 0.824 |  2.974 |
| p.ext_usda.a274_mg.kg          | mir_cubist_kssl_na_v1.2            |  0.700 |  0.024 | 0.638 | 0.763 |  2.591 |
| p.ext_usda.a274_mg.kg          | mir_cubist_ossl_na_v1.2            |  0.745 |  0.024 | 0.606 | 0.738 |  2.488 |
| p.ext_usda.a274_mg.kg          | visnir_cubist_ossl_na_v1.2         |  1.025 | -0.135 | 0.421 | 0.546 |  1.268 |
| ph.cacl2_usda.a481_index       | mir_cubist_kssl_na_v1.2            |  0.365 |  0.011 | 0.931 | 0.964 |  6.742 |
| ph.cacl2_usda.a481_index       | mir_cubist_ossl_na_v1.2            |  0.364 |  0.014 | 0.931 | 0.964 |  6.729 |
| ph.cacl2_usda.a481_index       | nir.neospectra_cubist_ossl_na_v1.2 |  0.677 |  0.017 | 0.738 | 0.846 |  3.545 |
| ph.cacl2_usda.a481_index       | visnir_cubist_ossl_na_v1.2         |  0.378 |  0.002 | 0.929 | 0.963 |  7.150 |
| ph.h2o_usda.a268_index         | mir_cubist_kssl_na_v1.2            |  0.385 |  0.003 | 0.916 | 0.955 |  5.825 |
| ph.h2o_usda.a268_index         | mir_cubist_ossl_na_v1.2            |  0.396 |  0.006 | 0.911 | 0.953 |  5.633 |
| ph.h2o_usda.a268_index         | nir.neospectra_cubist_ossl_na_v1.2 |  0.641 |  0.009 | 0.746 | 0.851 |  3.387 |
| ph.h2o_usda.a268_index         | visnir_cubist_ossl_na_v1.2         |  0.431 | -0.001 | 0.899 | 0.946 |  5.757 |
| s.tot_usda.a624_w.pct          | mir_cubist_kssl_na_v1.2            |  0.071 |  0.005 | 0.934 | 0.964 |  0.640 |
| s.tot_usda.a624_w.pct          | mir_cubist_ossl_na_v1.2            |  0.073 |  0.006 | 0.932 | 0.963 |  0.627 |
| s.tot_usda.a624_w.pct          | nir.neospectra_cubist_ossl_na_v1.2 |  0.080 |  0.008 | 0.886 | 0.938 |  0.341 |
| s.tot_usda.a624_w.pct          | visnir_cubist_kssl_na_v1.2         |  0.078 |  0.008 | 0.774 | 0.844 |  0.475 |
| s.tot_usda.a624_w.pct          | visnir_cubist_ossl_na_v1.2         |  0.082 |  0.008 | 0.746 | 0.827 |  0.452 |
| sand.tot_usda.c60_w.pct        | mir_cubist_kssl_na_v1.2            |  7.478 |  0.005 | 0.934 | 0.965 |  6.526 |
| sand.tot_usda.c60_w.pct        | mir_cubist_ossl_na_v1.2            |  8.332 |  0.004 | 0.917 | 0.956 |  5.845 |
| sand.tot_usda.c60_w.pct        | nir.neospectra_cubist_ossl_na_v1.2 | 18.155 |  0.631 | 0.586 | 0.722 |  2.579 |
| sand.tot_usda.c60_w.pct        | visnir_cubist_ossl_na_v1.2         | 15.124 |  0.041 | 0.676 | 0.797 |  2.843 |
| silt.tot_usda.c62_w.pct        | mir_cubist_kssl_na_v1.2            |  6.626 |  0.051 | 0.895 | 0.943 |  4.603 |
| silt.tot_usda.c62_w.pct        | mir_cubist_ossl_na_v1.2            |  7.312 |  0.046 | 0.875 | 0.931 |  4.404 |
| silt.tot_usda.c62_w.pct        | nir.neospectra_cubist_ossl_na_v1.2 | 13.786 |  0.184 | 0.538 | 0.672 |  2.169 |
| silt.tot_usda.c62_w.pct        | visnir_cubist_ossl_na_v1.2         | 11.254 |  0.160 | 0.668 | 0.791 |  2.488 |
| wr.1500kPa_usda.a417_w.pct     | mir_cubist_kssl_na_v1.2            |  0.185 | -0.002 | 0.940 | 0.969 |  4.457 |
| wr.1500kPa_usda.a417_w.pct     | mir_cubist_ossl_na_v1.2            |  0.188 | -0.002 | 0.938 | 0.968 |  4.411 |
| wr.1500kPa_usda.a417_w.pct     | nir.neospectra_cubist_ossl_na_v1.2 |  0.360 | -0.018 | 0.647 | 0.776 |  2.129 |
| wr.1500kPa_usda.a417_w.pct     | visnir_cubist_ossl_na_v1.2         |  0.426 | -0.036 | 0.607 | 0.730 |  1.848 |
| wr.33kPa_usda.a415_w.pct       | mir_cubist_kssl_na_v1.2            |  0.217 |  0.000 | 0.833 | 0.905 |  2.257 |
| wr.33kPa_usda.a415_w.pct       | mir_cubist_ossl_na_v1.2            |  0.220 |  0.000 | 0.830 | 0.903 |  2.268 |
| wr.33kPa_usda.a415_w.pct       | nir.neospectra_cubist_ossl_na_v1.2 |  0.381 | -0.025 | 0.312 | 0.456 |  1.208 |
| wr.33kPa_usda.a415_w.pct       | visnir_cubist_ossl_na_v1.2         |  0.347 | -0.037 | 0.573 | 0.697 |  1.657 |
| zn.ext_usda.a1073_mg.kg        | mir_cubist_kssl_na_v1.2            |  0.364 |  0.023 | 0.736 | 0.831 |  2.469 |
| zn.ext_usda.a1073_mg.kg        | mir_cubist_ossl_na_v1.2            |  0.353 |  0.032 | 0.603 | 0.724 |  1.725 |
