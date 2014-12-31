set -e
# set -x # DEBUG

. $WORKING_DIR/braindump.conf


OUTPUT_DIR=./stats
mkdir -p $OUTPUT_DIR

if [[ -z "$STATS_SCRIPT" ]]; then
  # Supervision sample script not set, use default

  # Global stats
  bash $UTIL_DIR/stats/global.sh $OUTPUT_DIR

  # Stats for each variable
  num_variables=${#VARIABLE_TABLES[@]};
  echo "  Examining $num_variables variable tables for stats...";
  for (( i=0; i<${num_variables}; i++ )); do
    table=${VARIABLE_TABLES[$i]}
    column=${VARIABLE_COLUMNS[$i]}
    words=
    docid=
    if [[ -n "$VARIABLE_WORDS_COLUMNS" ]]; then
      words=${VARIABLE_WORDS_COLUMNS[$i]}
      # Remove spaces
      words=`echo $words | tr -d ' '`
    fi
    if [[ -n "$VARIABLE_DOCID_COLUMNS" ]]; then
      docid=${VARIABLE_DOCID_COLUMNS[$i]}
    fi

    bash $UTIL_DIR/stats/single_variable.sh $OUTPUT_DIR $table $column $words $docid

  done;

  # Stats for each feature
  num_features=${#FEATURE_TABLES[@]}
  echo "  Examining $num_features feature tables for stats..."
  for (( i=0; i<${num_features}; i++ )); do
    table=${FEATURE_TABLES[$i]}
    column=${FEATURE_COLUMNS[$i]}

    printf "* Good-Turing estimation of prob. that next extracted feature is new:\n" >> $OUTPUT_DIR/$table.txt

    # Good-turing estimator
    $UTIL_DIR/stats/good_turing_estimator.sh $table $column $OUTPUT_DIR/$table.txt

  done

else
  # Just run the user-defined script
  bash $STATS_SCRIPT
fi
