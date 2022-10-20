from ortools.sat.python import cp_model
import sys

name = ""
nr_vertices = 0
nr_edges = 0
neighborhoods = []
weights = []

def fileReader(filename):
    file = open(filename, "r")

    # next line is "name"
    file.readline()
    # get name
    global name
    name = file.readline().replace("\n","")

    # next line is "nr_vertices"
    file.readline()
    # get nr_vertices
    global nr_vertices
    nr_vertices = int(file.readline())

    # next line is "nr_edges"
    file.readline()
    # get nr_edges
    global nr_edges
    nr_edges = int(file.readline())

    # next line is "neighborhoods"
    file.readline()
    # get neighborhoods
    global neighborhoods
    for i in range(nr_vertices):
        aux = file.readline().replace("\n","").split(",")
        for j in range(len(aux)):
            aux[j] = int(aux[j])
        neighborhoods.append(aux)

    # next line is "weights"
    file.readline()
    # get weigths
    global weights
    for i in range(nr_vertices):
        weights.append(int(file.readline().replace("\n","")))

    file.close()

# fileReader('Test_OR_Tools/graph2_1.txt')
fileReader(sys.argv[1])

print("Name = "+name)
print("nr_vertices = "+str(nr_vertices))
print("nr_edges = "+str(nr_edges))
print("neighborhoods = "+str(neighborhoods))
print("weights = "+str(weights))

# definition of tab_colors (different types of colors)
tab_colors = [i for i in range(nr_vertices)]

# Define a class for solution printing inheriting the CpSolverSolutionCallback
class SolutionPrinter(cp_model.CpSolverSolutionCallback):
  """Print intermediate solutions."""

  def __init__(self, variables):
    cp_model.CpSolverSolutionCallback.__init__(self)
    self.__variables = variables
    self.__solution_count = 0
    global tab_colors
    self.colors = tab_colors
    self.vertice_colors = []
  
  # This is a callback function which is called when a solution is found.
  def OnSolutionCallback(self):
    self.__solution_count += 1
    for v in self.__variables:
      print('{} = {}'.format(v, self.colors[self.Value(v)]), end = '\n')
      self.vertice_colors.append(self.colors[self.Value(v)])
    print()

  def SolutionCount(self):
    return self.__solution_count, self.vertice_colors

def graph_coloring(nr_vertices, connections, nr_colors):
      # Instantiate the CpModel 
  model = cp_model.CpModel()
  # Create a variable ranging from 0 to k for each vertice.
  vertices = [model.NewIntVar(0, nr_colors-1, 'x%i' %i) for i in range(nr_vertices)]

  # Add a constraint (i.e value of node A != value of node B) for each edge.
  for i, conn in enumerate(connections):
    model.Add(vertices[conn[0]] != vertices[conn[1]])
  
  # Objective function to minimize number color
  max_color = model.NewIntVar(0, nr_vertices, 'Max_Color')
  model.AddMaxEquality(max_color,vertices)
  model.Minimize(max_color)
  
  # Instantiate a Cp solver
  solver = cp_model.CpSolver()
  # Instantiate a callback function to print solution
  solution_printer = SolutionPrinter(vertices)
  # Search for all soltuions 
  # status = solver.SearchForAllSolutions(model, solution_printer)
  # Search best solution
  status = solver.Solve(model, solution_printer)
  count, colors = solution_printer.SolutionCount()
  print("Solution found : %i" % count)
  print('Problem solved in ', solver.WallTime(), ' seconds')
  # Return the color values
  return colors

# define number max of possible color
nr_colors = nr_vertices

# define each connection edges between 2 vertices 
connections = []
for i in range(len(neighborhoods)):
    for j in neighborhoods[i]:
        connections.append((i,j))

colors = graph_coloring(nr_vertices, connections, nr_colors)

print("Colors of each vertices : "+str(colors))

def weights_of_colors(weights, colors):
  color_weights = []

  for i in range(len(set(colors))):
    # get the index of the vertices with the same color
    index_vertices = [idx for idx,clr in enumerate(colors) if clr == i]
    # get weights of all vertices selected
    weights_vertices = []
    for j in index_vertices:
      weights_vertices.append(weights[j])
    # get max weight between all vertices weights
    color_weights.append(max(weights_vertices))

  return color_weights

print(weights_of_colors(weights,colors))
