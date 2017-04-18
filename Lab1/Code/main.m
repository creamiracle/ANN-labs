% 4.1-4.2
%values to change: eta, itr
sepdata %linear seperable data
delta %delta rule

%4.3
nsepdata %non-linear seperable data
delta

%5.1-5.2
%values to change: eta, hidden, itr, alpha
gen_delta %generalized delta rule

%5,3%%%%%%%%%%%%%%%Accuracy Problem!!!!
endata %encoder data
%value to change: eta,itr,alpha
%value doesn't change: hidden = 3
en_gen_delta 

%6 
fun_gen_delta

%7 generalization
generalization %split data 
%value to change:n = 10/25; hidden >20 or <5





