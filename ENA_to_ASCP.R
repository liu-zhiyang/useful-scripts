args = commandArgs(TRUE)
filename <- args[1]
#define the main function
ENA_to_ASCP <- function(filename){
  #this function was designed to convert the ENA file report to Aspera download list
  filereport <- read.table(filename, header = T, sep = "\t")
  fastq_ftp <- as.character(filereport$fastq_ft)
  ftp_url <- character()
  for (k in 1:length(fastq_ftp)) {
    url_temp <- strsplit(fastq_ftp[k],";")[[1]]
    ftp_url <- c(ftp_url,url_temp)
  }
  ascp_url <- gsub("ftp.sra.ebi.ac.uk","",ftp_url)
  run_accession <- filereport$run_accession
  write.table(ascp_url,
              paste("ascp_list_",strsplit(filename,"_")[[1]][4],".txt",sep = ""),
              quote = F,sep = "\n",row.names = F,col.names = F)
  write.table(run_accession,
              paste("run_accession_",strsplit(filename,"_")[[1]][4],".txt",sep = ""),
              quote = F,sep = "\n",row.names = F,col.names = F)
}
ENA_to_ASCP(filename)
