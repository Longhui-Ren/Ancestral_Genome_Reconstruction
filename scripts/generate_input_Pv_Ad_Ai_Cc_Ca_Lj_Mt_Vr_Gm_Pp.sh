#!/bin/bash

perl -e 'print ">Phavu\n"' > MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt
for k in {01..11}; do awk "\$3~/DAGchainer/ && \$2~/Pv$k/" indexed_synteny_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm1_Gm2_Pp_20180704.txt | awk '{print $1"\t"$4}' | sort -k2,2n | awk '{print $1}' | perl -pe 's/\n/ /g' | perl -ne 'print "$_\$\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt; done
perl -e 'print ">Aradu\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt
for k in {01..10}; do awk "\$3~/DAGchainer/ && \$8~/Aradu\.A$k/ && \$9/\$6>=0.5" indexed_synteny_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm1_Gm2_Pp_20180704.txt | awk '{print $1"\t"$7"\t"$8}' | perl -pe 's/matches=.*\d+\:(\d+)\.\.\d+/$1/g' | sort -k3,3n | awk '{print $2$1}' | perl -pe 's/\n/ /g;s/\+//g' | perl -ne 'print "$_\$\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt; done
perl -e 'print ">Araip\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt
for k in {01..10}; do awk "\$3~/DAGchainer/ && \$11~/Araip\.B$k/ && \$12/\$6>=0.5" indexed_synteny_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm1_Gm2_Pp_20180704.txt | awk '{print $1"\t"$10"\t"$11}' | perl -pe 's/matches=.*\d+\:(\d+)\.\.\d+/$1/g' | sort -k3,3n | awk '{print $2$1}' | perl -pe 's/\n/ /g;s/\+//g' | perl -ne 'print "$_\$\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt; done
perl -e 'print ">Cajca\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt
for k in {01..11}; do awk "\$3~/DAGchainer/ && \$14~/Cc$k/ && \$15/\$6>=0.5" indexed_synteny_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm1_Gm2_Pp_20180704.txt | awk '{print $1"\t"$13"\t"$14}' | perl -pe 's/matches=.*\d+\:(\d+)\.\.\d+/$1/g' | sort -k3,3n | awk '{print $2$1}' | perl -pe 's/\n/ /g;s/\+//g' | perl -ne 'print "$_\$\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt; done
perl -e 'print ">Cicar\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt
for k in {1..8}; do awk "\$3~/DAGchainer/ && \$17~/Ca$k/ && \$18/\$6>=0.5" indexed_synteny_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm1_Gm2_Pp_20180704.txt | awk '{print $1"\t"$16"\t"$17}' | perl -pe 's/matches=.*\d+\:(\d+)\.\.\d+/$1/g' | sort -k3,3n | awk '{print $2$1}' | perl -pe 's/\n/ /g;s/\+//g' | perl -ne 'print "$_\$\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt; done
perl -e 'print ">Lotja\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt
for k in {1..6}; do awk "\$3~/DAGchainer/ && \$20~/Lj$k/ && \$21/\$6>=0.5" indexed_synteny_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm1_Gm2_Pp_20180704.txt | awk '{print $1"\t"$19"\t"$20}' | perl -pe 's/matches=.*\d+\:(\d+)\.\.\d+/$1/g' | sort -k3,3n | awk '{print $2$1}' | perl -pe 's/\n/ /g;s/\+//g' | perl -ne 'print "$_\$\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt; done
perl -e 'print ">Medtr\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt
for k in {1..8}; do awk "\$3~/DAGchainer/ && \$23~/Mt$k/ && \$24/\$6>=0.5" indexed_synteny_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm1_Gm2_Pp_20180704.txt | awk '{print $1"\t"$22"\t"$23}' | perl -pe 's/matches=.*\d+\:(\d+)\.\.\d+/$1/g' | sort -k3,3n | awk '{print $2$1}' | perl -pe 's/\n/ /g;s/\+//g' | perl -ne 'print "$_\$\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt; done
perl -e 'print ">Vigra\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt
for k in {01..11}; do awk "\$3~/DAGchainer/ && \$26~/Vr$k/ && \$27/\$6>=0.5" indexed_synteny_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm1_Gm2_Pp_20180704.txt | awk '{print $1"\t"$25"\t"$26}' | perl -pe 's/matches=.*\d+\:(\d+)\.\.\d+/$1/g' | sort -k3,3n | awk '{print $2$1}' | perl -pe 's/\n/ /g;s/\+//g' | perl -ne 'print "$_\$\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt; done
perl -e 'print ">Glyma\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt
for k in {01..20}; do awk "\$3~/DAGchainer/ && \$29~/Gm$k/ && \$30/\$6>=0.5" indexed_synteny_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm1_Gm2_Pp_20180704.txt | awk '{print $1"\t"$28"\t"$29}' | perl -pe 's/matches=.*\d+\:(\d+)\.\.\d+/$1/g' > temp_Gm$k.txt; awk "\$3~/DAGchainer/ && \$32~/Gm$k/ && \$33/\$6>=0.5" indexed_synteny_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm1_Gm2_Pp_20180704.txt | awk '{print $1"\t"$31"\t"$32}' | perl -pe 's/matches=.*\d+\:(\d+)\.\.\d+/$1/g' >> temp_Gm$k.txt; sort -k3,3n temp_Gm$k.txt | awk '{print $2$1}' | perl -pe 's/\n/ /g;s/\+//g' | perl -ne 'print "$_\$\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt; done
rm temp_Gm*.txt
perl -e 'print ">Prupe\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt
for k in {01..08}; do awk "\$3~/DAGchainer/ && \$35~/Pp$k/ && \$36/\$6>=0.5" indexed_synteny_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm1_Gm2_Pp_20180704.txt | awk '{print $1"\t"$34"\t"$35}' | perl -pe 's/matches=.*\d+\:(\d+)\.\.\d+/$1/g' | sort -k3,3n | awk '{print $2$1}' | perl -pe 's/\n/ /g;s/\+//g' | perl -ne 'print "$_\$\n"' >> MLGO_Pv_Ad_Ai_Cc_Ca_Lj_Mt_Vr_Gm_Pp.txt; done
