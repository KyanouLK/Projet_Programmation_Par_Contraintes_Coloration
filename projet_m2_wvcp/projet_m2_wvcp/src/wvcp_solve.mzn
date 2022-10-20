include "wvcp_heuristics.mzn";


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RESOLUTION

%TODO restart annotation raises error/warning '% Error in search annotation: Unknown search annotation. Ignore search annotation!'
solve :: wvcp_search() :: wvcp_restart()
  minimize(x_score);
%  satisfy;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHAGE

output
		["\n"]
% ++  ["COLORS\t" ++ show(COLOR)]
% ++  ["\n"]
% ++  ["VERTICES\t\t" ++ show(nr_vertices)]
% ++  ["\n"]
% % ++  ["NEIGHBORS\t\t"] ++ [show(v) ++ "-" ++ show(neighbours[v]) ++ " " | v in VERTEX]
% % ++  ["\n"]
% % ++  ["CLIQUES\t\t" ++ show(clique)]
% % ++  ["\n"]
% ++  ["Density\t\t" ++ show(round(100*density)) ++ "%"]
% ++  ["\n"]
% % ++  ["WEIGHTS\t\t"] ++ [show(v) ++ "-" ++ show(weight[v]) ++ " " | v in VERTEX]
% % ++  ["\n"]
% ++  ["Max weight\t" ++ show(max(weight))]
% ++  ["\n"]
% ++  ["Mean weight\t" ++ show(round(sum(weight)/nr_vertices))]
% ++  ["\n"]
% ++  ["**************************"]
% ++  ["\n"]
% ++	["FLAGS\t"] 
% ++  ["\tWVCP_BOUNDS=" ++ show(WVCP_BOUNDS) ++ " + " ++ "WVCP_MODEL=" ++ show(WVCP_MODEL)]
% ++  ["\n"]
% ++  ["\t + " ++ "\tWVCP_SEARCH_STRATEGY=" ++ show(WVCP_SEARCH_STRATEGY) ++ "\t+\t" ++ "WVCP_SEARCH_RESTART=" ++ show(WVCP_SEARCH_RESTART)]
% ++  ["\n"]
% ++  ["\t + " ++ "\tWVCP_SEARCH_VARIABLES_VERTICES=" ++ show(WVCP_SEARCH_VARIABLES_VERTICES) ++ "\t+\t" ++ "WVCP_SEARCH_DOMAIN_VERTICES=" ++ show(WVCP_SEARCH_DOMAIN_VERTICES)]
% ++  ["\n"]
% ++  ["\t + " ++ "\tWVCP_SEARCH_VARIABLES_WEIGHTS=" ++ show(WVCP_SEARCH_VARIABLES_WEIGHTS) ++ "\t+\t" ++ "WVCP_SEARCH_DOMAIN_WEIGHTS=" ++ show(WVCP_SEARCH_DOMAIN_WEIGHTS)]
% ++  ["\n"]
% ++  ["\t + " ++ "\tWVCP_SEARCH_VARIABLES_COLORS=" ++ show(WVCP_SEARCH_VARIABLES_COLORS) ++ "\t+\t" ++ "WVCP_SEARCH_DOMAIN_COLORS=" ++ show(WVCP_SEARCH_DOMAIN_COLORS)]
% % ++  ["\n"]
% % ++  ["**************************"]
% % ++  ["\n"]
% % ++  ["COLORING\t"] ++ [show(v) ++ "=" ++ show(x_color[v]) ++ " " | v in VERTEX]
% % ++  ["\n"]
% % ++  ["PLACEMENT\t"] ++ [show(c) ++ "=" ++ show(x_vertices[c]) ++ " " | c in COLOR]
% % ++  ["\n"]
% % ++  ["WEIGHTS\t"] ++ [show(c) ++ "=" ++ show(x_weight[c]) ++ " " | c in COLOR]
% ++  ["\n"]
% ++  ["**************************"]
% ++  ["\n"]
% ++  ["Sum weights\t" ++ show(sum(weight))]
% ++  ["\n"]
% ++  ["MWSSP*\t\t" ++ show(sum(weight)-ub_score)]
% ++  ["\n"]

% ++ [show(array1d(R_VERTEX, [GNA[v]  | v in R_VERTEX]))]
% ++  ["\n"]
% ++ [show(array1d(R_VERTEX, [{u | u in R_VERTEX where u in GNA[v] /\ neighbours[v] subset neighbours[u]} | v in R_VERTEX]))]
% ++  ["\n"]
% ++ [show(array1d(R_VERTEX, 
% 						if (M_SORT in WVCP_M) /\ I_SORT
% 						then	[min([{u | u in R_VERTEX where u in GNA[v] /\ neighbours[v] subset neighbours[u]} | v in R_VERTEX][v] union {v}) | v in R_VERTEX]
% 						else	[arg_max(u in [{u | u in R_VERTEX where u in GNA[v] /\ neighbours[v] subset neighbours[u]} | v in R_VERTEX][v] union {v})(weight[u]) | v in R_VERTEX]
% 						endif))]
% ++  ["\n"]

++		["I_SORT=" ++ show(I_SORT) ++ "\tWVCP_B=" ++ show(WVCP_B) ++ "\tWVCP_M=" ++ show(WVCP_M)]
++  ["\n"]
++  ["WVCP\t\t" ++ show(x_score) ++ " <= " ++ show(ub_score) ++ " <= " ++ show(sum(weight))]
++  ["\n"]
% ++  ["COLORS\t"] ++ [show(x_nr_used) ++ " / " ++ show(x_ub_used) ++ " / " ++ show(card(R_VERTEX))]
++  ["COLORS\t\t"] ++ [show(x_nr_used) ++ " / " ++ show(card(R_VERTEX))]
++  ["\n"]
++  ["S-GDV\t\t"] ++ [show(count_SGDV())]
++  ["\n"]
++  ["D-GDV\t\t"] ++ [show(count_DGDV())]
++  ["\n"]
++  ["S-HDC\t\t"] ++ [show(count_SGDC())]
++  ["\n"]
++  ["D-HDC\t\t"] ++ [show(count_DGDC())]
;

%date; minizinc --solver or-tools --time-limit 3600000 --random-seed 1 --parallel 1 --compiler-statistics --solver-statistics --intermediate -D WVCP_SEARCH_STRATEGY=VERTICES_GENERIC -D WVCP_SEARCH_RESTART=RESTART_NONE -D "WVCP_SEARCH_VARIABLES_COLORS=WVCPSV(INPUT_ORDER)" -D WVCP_SEARCH_DOMAIN_COLORS=INDOMAIN_MIN -D "WVCP_SEARCH_VARIABLES_WEIGHTS=WVCPSV(INPUT_ORDER)" -D WVCP_SEARCH_DOMAIN_WEIGHTS=INDOMAIN_SPLIT -D "WVCP_SEARCH_VARIABLES_VERTICES=WVCPSV(FIRST_FAIL)" -D WVCP_SEARCH_DOMAIN_VERTICES=INDOMAIN_SPLIT wvcp_solve.mzn no_cliques.dzn no_ub_colors.dzn no_ub_score.dzn -D "WB={}" -D "WM={S_R2}" ../original_wvcp_dzn/p40.dzn; beep;

