library(testthat)
library(sodium)
library(DiagrammeR)

grade_my_hw <- function(x,test_file){
  encrypted_text2 <- as.raw(as.hexmode((readr::read_lines(test_file))))
  key2 <- as.raw(as.hexmode((readr::read_lines('/home/expdes/public/id_rsa'))))
  decrypted_text <- unserialize(simple_decrypt(encrypted_text2, key2))
  readr::write_file(decrypted_text, 'tmp_test.r')
  trial_test <- data.frame(testthat::test_file('tmp_test.r', reporter = "minimal"))
  file.remove('tmp_test.r')
  trial_test <- trial_test[trial_test$test==x]
  return(trial_test$failed == 0)
}

show_grade <- function(p, x){
  color <- ifelse(p , "green", "red")
  DiagrammeR::grViz(sprintf("digraph {
  graph [layout = dot, rankdir = TB]
  
  node [shape = rectangle]        
  rec1 [label = %s color = %s fillcolor = %s style = filled]
  }", x, color, color),  height = 100)
}
