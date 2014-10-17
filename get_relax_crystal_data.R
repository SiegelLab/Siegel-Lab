# relevant result tables - sc_ and bb_final_df

# Idea - change ContactCounter to make main_chain_contacts/num_lig to be considered "100%" then the relaxed_contacts/num_lig is taken as a percentage of that - so either 98% (less) 102% (more) etc
# Add new column dividing num of contacts by lig into the new col (could color coodinater later so you can see if there are clusters of proteins with big or small ligs


# Usage is Rscript <filename>
# Usage in R source("/home/mlnance/github/r_scripts/get_relax_crystal_data.R")

# Removes all variables in environment before script runs
rm(list=ls(all=TRUE))


## Get all of the relevant results text files from contact_results
bb_crystal <- read.table("/home/mlnance/contact/crystal/contact_results/results_backbone_crystal.txt",header=T)
bb_main_chain <- read.table("/home/mlnance/contact/crystal/contact_results/results_backbone_main_chain.txt",header=T)
bb_relaxed <- read.table("/home/mlnance/contact/crystal/contact_results/results_backbone_relaxed.txt",header=T)

sc_crystal <- read.table("/home/mlnance/contact/crystal/contact_results/results_sidechain_crystal.txt",header=T)
sc_main_chain <- read.table("/home/mlnance/contact/crystal/contact_results/results_sidechain_main_chain.txt",header=T)
sc_relaxed <- read.table("/home/mlnance/contact/crystal/contact_results/results_sidechain_relaxed.txt",header=T)

res_crystal <- read.table("/home/mlnance/contact/crystal/contact_results/results_crystal.txt",header=T)
res_main_chain <- read.table("/home/mlnance/contact/crystal/contact_results/results_main_chain.txt",header=T)
res_relaxed <- read.table("/home/mlnance/contact/crystal/contact_results/results_relaxed.txt",header=T)

num_lig_crystal <- read.table("/home/mlnance/contact/crystal/contact_results/results_num_lig_crystal.txt",header=T)
num_lig_main_chain <- read.table("/home/mlnance/contact/crystal/contact_results/results_num_lig_main_chain.txt",header=T)
num_lig_relaxed <- read.table("/home/mlnance/contact/crystal/contact_results/results_num_lig_relaxed.txt",header=T)

bb_contact_vs_lig_crystal <- read.table("/home/mlnance/contact/crystal/contact_results/results_backbone_normalized_crystal.txt",header=T)
bb_contact_vs_lig_main_chain <- read.table("/home/mlnance/contact/crystal/contact_results/results_backbone_normalized_main_chain.txt",header=T)
bb_contact_vs_lig_relaxed <- read.table("/home/mlnance/contact/crystal/contact_results/results_backbone_normalized_relaxed.txt",header=T)

sc_contact_vs_lig_crystal <- read.table("/home/mlnance/contact/crystal/contact_results/results_sidechain_normalized_crystal.txt",header=T)
sc_contact_vs_lig_main_chain <- read.table("/home/mlnance/contact/crystal/contact_results/results_sidechain_normalized_main_chain.txt",header=T)
sc_contact_vs_lig_relaxed <- read.table("/home/mlnance/contact/crystal/contact_results/results_sidechain_normalized_relaxed.txt",header=T)



## Change the names of the columns to make appropriate tables
orig_name_list <- c("pp","pn","np","nn")

crystal_name_change <- c("crystal_pp","crystal_pn","crystal_np","crystal_nn")
crystal_sc_name_change <- c("sc_num_crystal_pp","sc_num_crystal_pn","sc_num_crystal_np","sc_num_crystal_nn")
crystal_bb_name_change <- c("bb_num_crystal_pp","bb_num_crystal_pn","bb_num_crystal_np","bb_num_crystal_nn")
a <- 1
for (i in orig_name_list) {
    x <- grep(i,names(res_crystal))
    names(res_crystal)[x] <- crystal_name_change[a]
    y <- grep(i,names(sc_crystal))
    names(sc_crystal)[y] <- crystal_sc_name_change[a]
    z <- grep(i,names(bb_crystal))
    names(bb_crystal)[z] <- crystal_bb_name_change[a]
    a <- a+1
}

main_chain_name_change <- c("main_chain_pp","main_chain_pn","main_chain_np","main_chain_nn")
main_chain_sc_name_change <- c("sc_num_main_chain_pp","sc_num_main_chain_pn","sc_num_main_chain_np","sc_num_main_chain_nn")
main_chain_bb_name_change <- c("bb_num_main_chain_pp","bb_num_main_chain_pn","bb_num_main_chain_np","bb_num_main_chain_nn")
b <- 1
for (i in orig_name_list) {
    x <- grep(i,names(res_main_chain))
    names(res_main_chain)[x] <- main_chain_name_change[b]
    y <- grep(i,names(sc_main_chain))
    names(sc_main_chain)[y] <- main_chain_sc_name_change[b]
    z <- grep(i,names(bb_main_chain))
    names(bb_main_chain)[z] <- main_chain_bb_name_change[b]
    b <- b+1
}

norm_main_chain_sc_name_change <- c("sc_mc_contacts_vs_lig_pp","sc_mc_contacts_vs_lig_pn","sc_mc_contacts_vs_lig_np","sc_mc_contacts_vs_lig_nn")
norm_main_chain_bb_name_change <- c("bb_mc_contacts_vs_lig_pp","bb_mc_contacts_vs_lig_pn","bb_mc_contacts_vs_lig_np","bb_mc_contacts_vs_lig_nn")
c <- 1
for (i in orig_name_list) {
    x <- grep(i,names(sc_contact_vs_lig_main_chain))
    names(sc_contact_vs_lig_main_chain)[x] <- norm_main_chain_sc_name_change[c]
    y <- grep(i,names(bb_contact_vs_lig_main_chain))
    names(bb_contact_vs_lig_main_chain)[y] <- norm_main_chain_bb_name_change[c]
    c <- c+1
}


relaxed_name_change <- c("relaxed_pp","relaxed_pn","relaxed_np","relaxed_nn")
relaxed_sc_name_change <- c("sc_num_relaxed_pp","sc_num_relaxed_pn","sc_num_relaxed_np","sc_num_relaxed_nn")
relaxed_bb_name_change <- c("bb_num_relaxed_pp","bb_num_relaxed_pn","bb_num_relaxed_np","bb_num_relaxed_nn")
c <- 1
for (i in orig_name_list) {
    names(res_relaxed)[1] <- "score_file_used"
    x <- grep(i,names(res_relaxed))
    names(res_relaxed)[x] <- relaxed_name_change[c]
    names(sc_relaxed)[1] <- "score_file_used"
    y <- grep(i,names(sc_relaxed))
    names(sc_relaxed)[y] <- relaxed_sc_name_change[c]
    names(bb_relaxed)[1] <- "score_file_used"
    z <- grep(i,names(bb_relaxed))
    names(bb_relaxed)[z] <- relaxed_bb_name_change[c]
    c <- c+1
}


norm_relaxed_sc_name_change <- c("sc_rlx_contacts_vs_lig_pp","sc_rlx_contacts_vs_lig_pn","sc_rlx_contacts_vs_lig_np","sc_rlx_contacts_vs_lig_nn")
norm_relaxed_bb_name_change <- c("bb_rlx_contacts_vs_lig_pp","bb_rlx_contacts_vs_lig_pn","bb_rlx_contacts_vs_lig_np","bb_rlx_contacts_vs_lig_nn")
c <- 1
for (i in orig_name_list) {
    x <- grep(i,names(sc_contact_vs_lig_relaxed))
    names(sc_contact_vs_lig_relaxed)[x] <- norm_relaxed_sc_name_change[c]
    y <- grep(i,names(bb_contact_vs_lig_relaxed))
    names(bb_contact_vs_lig_relaxed)[y] <- norm_relaxed_bb_name_change[c]
    c <- c+1
}



### Make a dataframe based on SIDECHAIN results
sc_relaxed$score_file_used <- as.character(sc_relaxed$score_file_used)
d <- 1
while (d < length(sc_relaxed[,1])+1) {
      sc_relaxed[d,1] <- paste(substr(sc_relaxed[d,1],1,4),substr(sc_relaxed[d,1],21,24),sep="_")
      d <- d+1
}

sc_final_df <- data.frame(sc_relaxed[1],num_lig_relaxed[2])
names(sc_final_df)[2] <- "num_lig_rlx"



## Get contact results for main chain and relaxed as well as contact vs ligand results
g <- 2
while (g < (max(length(sc_main_chain[1,]),length(sc_relaxed[1,])+1))) {
      sc_final_df <- data.frame(sc_final_df,sc_main_chain[g],sc_contact_vs_lig_main_chain[g],sc_contact_vs_lig_relaxed[g],sc_relaxed[g])
      g <- g+1
}


## Save sidechain_dataframe to a csv .txt file
filename <- file("/home/mlnance/contact/crystal/contact_results/Sidechain_Results_Summary.txt")
write.csv(sc_final_df,file=filename,row.names=FALSE)





### Make a dataframe based on BACKBONE results
bb_relaxed$score_file_used <- as.character(bb_relaxed$score_file_used)
d <- 1
while (d < length(bb_relaxed[,1])+1) {
      bb_relaxed[d,1] <- paste(substr(bb_relaxed[d,1],1,4),substr(bb_relaxed[d,1],21,24),sep="_")
      d <- d+1
}

bb_final_df <- data.frame(bb_relaxed[1],num_lig_relaxed[2])
names(bb_final_df)[2] <- "num_lig_rlx"



## Get contact results for main chain and relaxed as well as contact vs ligand results
g <- 2
while (g < (max(length(bb_main_chain[1,]),length(bb_relaxed[1,])+1))) {
      bb_final_df <- data.frame(bb_final_df,bb_main_chain[g],bb_contact_vs_lig_main_chain[g],bb_contact_vs_lig_relaxed[g],bb_relaxed[g])
      g <- g+1
}


## Save backbone_dataframe to a csv .txt file
filename <- file("/home/mlnance/contact/crystal/contact_results/Backbone_Results_Summary.txt")
write.csv(bb_final_df,file=filename,row.names=FALSE)



## Make a data frame to count total number of contacts

#for main chain
total_mc_df <- data.frame()
i <- 1
while (i < nrow(res_relaxed)+1) {
      total_num_mc_contacts = sum(res_main_chain[i,2:5])
      total_mc_df <- rbind(total_mc_df, total_num_mc_contacts)
      i <- i+1
}
names(total_mc_df)[1] <- "tot_num_mc_contacts"

# for relaxed
total_rlx_df <- data.frame()
h <- 1
while (h < nrow(res_main_chain)+1) {
      total_num_rlx_contacts = sum(res_relaxed[h,2:5])
      total_rlx_df <- rbind(total_rlx_df, total_num_rlx_contacts)
      h <- h+1
}
names(total_rlx_df)[1] <- "tot_num_rlx_contacts"




# divide total num contacts by num lig atms
# make another for loop to do that, then add to data frame


# num_lig_main_chain[1] = pdbname, [2] = num lig atms
total_df <- cbind(num_lig_main_chain[1], total_mc_df, total_rlx_df, num_lig_main_chain[2])

