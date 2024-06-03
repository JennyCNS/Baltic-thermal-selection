#plink --file kmaf --make-bed --recode --allow-extra-chr --out kmaf
#run admixture
# ADMIXTURE does not accept chromosome names that are not human chromosomes. We  will thus just exchange the first column by 0

FILE=pca

awk '{$1=0;print $0}' $FILE.bim > $FILE.bim.tmp
mv $FILE.bim.tmp $FILE.bim
admixture --cv $FILE.bed 2 > log2.out

#ADMIXTURE produced 2 files: .Q which contains cluster assignments for each individual and .P which contains for each SNP the population allele frequencies.

#Lets now run it in a for loop with K=2 to K=5 and direct the output into log files

for i in {2..10}
do
admixture --cv $FILE.bed $i > log${i}.out
done

#To identify the best value of k clusters which is the value with lowest cross-validation error, we need to collect the cv errors. Below are three different w                          ays to extract the number of K and the CV error for each corresponding K. Like                           we said at the start of the course, there are many ways to achieve the same thi                          ng in bioinformatics!

#grep "CV" *out | awk '{print $3,$4}' | sed -e 's/(//;s/)//;s/://;s/K=//'  > admixture.cv.error
grep "CV" *out | awk '{print $3,$4}' | cut -c 4,7-20 > $FILE.cv.error

awk '/CV/ {print $3,$4}' *out | cut -c 4,7-20 > $FILE.cv.error

#best is k=4

awk '{split($1,name,"."); print $1,name[2]}' $FILE.nosex > $FILE.list

done

