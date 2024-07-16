#!/bin/bash

display_usage_file() {
  echo "Please insert correct arguments: <log_file_path>"
}

if [ $# -eq 0 ]; then
  display_usage_file
  exit 1
fi

LOG_FILE=$1

# Check if the log file exists
if [! -f "$LOG_FILE" ]; then
  echo "Error: Log file $LOG_FILE does not exist."
  exit 1
fi

# Variables
ERROR_KEYWORD="ERROR"
CRITICAL_KEYWORD="CRITICAL"
DATE=$(date +"%Y-%m-%d")
SUMMARY_REPORT="summary_report_$DATE.txt"
ARCHIVE_DIR="processed_logs"

# Create a summary report
{
  echo "Date of analysis: $DATE"
  echo "Log file name: $LOG_FILE"
} > "$SUMMARY_REPORT"

# Total lines processed
TOTAL_LINES=$(wc -l < "$LOG_FILE")
echo "Total lines processed: $TOTAL_LINES" >> "$SUMMARY_REPORT"

# Count the number of error messages
ERROR_COUNT=$(grep -c "$ERROR_KEYWORD" "$LOG_FILE")
echo "Total error count: $ERROR_COUNT" >> "$SUMMARY_REPORT"

# List of critical events with line numbers
echo "List of critical events with line numbers:" >> "$SUMMARY_REPORT"
grep -n "$CRITICAL_KEYWORD" "$LOG_FILE" >> "$SUMMARY_REPORT"

# Print the summary report
cat "$SUMMARY_REPORT"
