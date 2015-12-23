get_x_last_datapoints() {
  local lineCount=$1

  if [ -z "$lineCount" ]; then
    lineCount=($(wc ~/uranium_rock.txt -l))
  fi

  awk "NR > count-$lineCount" count=$( wc -l < ~/uranium_rock.txt ) ~/uranium_rock.txt
}

graphit() {
  get_x_last_datapoints $1 | awk '(/[wt]/) {next}{print NR, substr($4, 1, length($4)-1)}' > ~/plot/plot.dat
  gnuplot graph_script &> /dev/null
}

serve_plot() {
  python -m SimpleHTTPServer &> /dev/null &
  while true
  do
      graphit 2000
      sleep 1
  done
}
