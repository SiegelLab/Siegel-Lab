# runs the get_relax_crystal_data.R to get data, then graphs results from backbone and sidechain data frames (bb_final_df and sc_final_df)

# Run program to get the data
source("/home/mlnance/github/r_scripts/get_relax_crystal_data.R")

x <- 0
y <- 1

## Plot graphs for BACKBONE

# Plot main chain vs relaxed backbone polar to polar vs a line of best fit
pdf("BB_contacts_vs_lig_mc_pp")
plot(bb_final_df$bb_mc_contacts_vs_lig_pp,bb_final_df$bb_rlx_contacts_vs_lig_pp,main="Contacts over Num of Lig Atoms - Backbone PP",xlab="Percent for Main Chain", ylab="Percent for Relaxed")
#res <- lm(bb_final_df$bb_mc_contacts_vs_lig_pp~bb_final_df$bb_rlx_contacts_vs_lig_pp)
abline(x,y)
dev.off()

# Plot main chain vs relaxed backbone polar to nonpolar vs a line of best fit
pdf("BB_contacts_vs_lig_mc_pn")
plot(bb_final_df$bb_mc_contacts_vs_lig_pn,bb_final_df$bb_rlx_contacts_vs_lig_pn, main="Contacts over Num of Lig Atoms - Backbone PN",xlab="Percent for Main Chain", ylab="Percent for Relaxed")
#res <- lm(bb_final_df$bb_mc_contacts_vs_lig_pn~bb_final_df$bb_rlx_contacts_vs_lig_pn)
abline(x,y)
dev.off()

# Plot backbone vs relaxed nonpolar to polar vs a line of best fit
pdf("BB_contacts_vs_lig_mc_np")
plot(bb_final_df$bb_mc_contacts_vs_lig_np,bb_final_df$bb_rlx_contacts_vs_lig_np, main="Contacts over Num of Lig Atoms - Backbone NP",xlab="Percent for Main Chain", ylab="Percent for Relaxed")
#res <- lm(bb_final_df$bb_mc_contacts_vs_lig_np~bb_final_df$bb_rlx_contacts_vs_lig_np)
abline(x,y)
dev.off()

# Plot backbone vs relaxed nonpolar to nonpolar vs a line of best fit
pdf("BB_contacts_vs_lig_mc_nn")
plot(bb_final_df$bb_mc_contacts_vs_lig_nn,bb_final_df$bb_rlx_contacts_vs_lig_nn, main="Contacts over Num of Lig Atoms - Backbone NN",xlab="Percent for Main Chain", ylab="Percent for Relaxed")
#res <- lm(bb_final_df$bb_mc_contacts_vs_lig_np~bb_final_df$bb_rlx_contacts_vs_lig_np)
abline(x,y)
dev.off()



## Plot graphs for SIDECHAIN

# Plot main chain vs relaxed sidechain polar to polar vs a line of best fit
pdf("SC_contacts_vs_lig_mc_pp")
plot(sc_final_df$sc_mc_contacts_vs_lig_pp,sc_final_df$sc_rlx_contacts_vs_lig_pp, main="Contacts over Num of Lig Atoms - Side Chain PP",xlab="Percent for Main Chain", ylab="Percent for Relaxed")
#res <- lm(sc_final_df$sc_mc_contacts_vs_lig_pp~sc_final_df$sc_rlx_contacts_vs_lig_pp)
abline(x,y)
dev.off()


# Plot main chain vs relaxed sidechain polar to nonpolar vs a line of best fit
pdf("SC_contacts_vs_lig_mc_pn")
plot(sc_final_df$sc_rlx_contacts_vs_lig_pn, sc_final_df$sc_mc_contacts_vs_lig_pn, main="Contacts over Num of Lig Atoms - Side Chain PN",xlab="Percent for Main Chain", ylab="Percent for Relaxed")
#res <- lm(sc_final_df$sc_mc_contacts_vs_lig_pn~sc_final_df$sc_rlx_contacts_vs_lig_pn)
abline(x,y)
dev.off()


# Plot main chain vs relaxed sidechain nonpolar to polar vs a line of best fit
pdf("SC_contacts_vs_lig_mc_np")
plot(sc_final_df$sc_mc_contacts_vs_lig_np,sc_final_df$sc_rlx_contacts_vs_lig_np, main="Contacts over Num of Lig Atoms - Side Chain NP",xlab="Percent for Main Chain", ylab="Percent for Relaxed")
#res <- lm(sc_final_df$sc_mc_contacts_vs_lig_np~sc_final_df$sc_rlx_contacts_vs_lig_np)
abline(x,y)
dev.off()


# Plot main chain vs relaxed sidechain nonpolar to nonpolar vs a line of best fit
pdf("SC_contacts_vs_lig_mc_nn")
plot(sc_final_df$sc_rlx_contacts_vs_lig_nn,sc_final_df$sc_mc_contacts_vs_lig_nn, main="Contacts over Num of Lig Atoms - Side Chain NN",xlab="Percent for Main Chain", ylab="Percent for Relaxed")
#res <- lm(sc_final_df$sc_mc_contacts_vs_lig_nn~sc_final_df$sc_rlx_contacts_vs_lig_nn)
abline(x,y)
dev.off()
