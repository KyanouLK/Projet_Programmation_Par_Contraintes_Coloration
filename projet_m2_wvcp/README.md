# Instances for Graph Coloring Problem and Weighted Vertex Coloring Problem

This repo lists several instances used in the Graph Coloring Problem (GCP) and the Weighted Vertex Coloring Problem (WVCP), original graph and reduced version.

All instances can be found in `original_graphs`. The reduced version of the graphs can be found in `reduced_wvcp`.

The vertices of each reduced instance are sorted by weight then by degree if equal weight then by the sum of the weights of theirs neighbors if same degree.

You can find three types of files:

    - .col files : from the DIMACS challenge (vertex numbers start at 1)
    - .edgelist files : each line is an edge between two nodes (vertex numbers start at 0)
    - .col.w files : line 1 is the weight of vertex 0, line 2 the weight of vertex 1, ...

## List of instances

DIMAC_large.txt, DIMAC_small.txt, pxx.txt and rxx.txt are the lists of instances used in the state of the art (for WVCP) to compare the algorithms. other.txt lists instances in the directory but not currently used for comparison in the state of the art (for WVCP).

## source of the files :

- various ones for GCP : https://sites.google.com/site/graphcoloring/files
- wvcp_original: http://www.info.univ-angers.fr/pub/hao/wvcp.html
- graph_coloring : DIMACS Challenge II
- bandwidth_multicoloring_instances : https://mat.gsia.cmu.edu/COLOR04/
- shared by other teams working on WVCP
