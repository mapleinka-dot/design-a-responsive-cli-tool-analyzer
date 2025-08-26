# eq5c_design_a_respon.R

# Load necessary libraries
library(argparse)
library(cli)

# Define the analyzer function
analyzer <- function(input_file, output_file, threshold) {
  # Load the input data
  data <- read.csv(input_file)
  
  # Perform the analysis
  results <- data %>% 
    group_by(category) %>% 
    summarize(mean_value = mean(value), count = n())
  
  # Filter the results based on the threshold
  filtered_results <- results %>% 
    filter(mean_value > threshold)
  
  # Save the results to the output file
  write.csv(filtered_results, output_file, row.names = FALSE)
}

# Define the CLI interface
cli_app <- function() {
  # Define the arguments
  parser <- ArgumentParser(description = "A responsive CLI tool analyzer")
  parser <- add_argument(parser, "input_file", type = "character", help = "Input file path")
  parser <- add_argument(parser, "output_file", type = "character", help = "Output file path")
  parser <- add_argument(parser, "threshold", type = "numeric", help = "Threshold value")
  
  # Parse the arguments
  args <- parse_args(parser)
  
  # Call the analyzer function
  analyzer(args$input_file, args$output_file, args$threshold)
}

# Run the CLI app
cli_app()