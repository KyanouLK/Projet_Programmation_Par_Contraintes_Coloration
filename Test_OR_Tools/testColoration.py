from ortools.sat.python import cp_model

# Define a class for solution printing inheriting the CpSolverSolutionCallback
class SolutionPrinter(cp_model.CpSolverSolutionCallback):
  """Print intermediate solutions."""

  def __init__(self, variables):
    cp_model.CpSolverSolutionCallback.__init__(self)
    self.__variables = variables
    self.__solution_count = 0
    self.colors = [1, 2, 3, 4]
    self.node_colors = []
  
  # This is a callback function which is called when a solution is found.
  def OnSolutionCallback(self):
    self.__solution_count += 1
    for v in self.__variables:
      print('{} = {}'.format(v, self.colors[self.Value(v)]), end = '\n')
      self.node_colors.append(self.colors[self.Value(v)])
    print()

  def SolutionCount(self):
    return self.__solution_count, self.node_colors

# A function to solve the graph coloring problem
#def graph_coloring(num_nodes, connections, k, num_solutions=2):
def graph_coloring(num_nodes, connections, k):
  # Instantiate the CpModel 
  model = cp_model.CpModel()
  # Create a variable ranging from 0 to k for each node.
  nodes = [model.NewIntVar(0, k-1, 'x%i' %i) for i in range(num_nodes)]

  # Add a constraint (i.e value of node A != value of node B) for each edge.
  for i, conn in enumerate(connections):
    model.Add(nodes[conn[0]] != nodes[conn[1]])
  
  # Instantiate a Cp solver
  solver = cp_model.CpSolver()
  # Instantiate a callback function to print solution
  solution_printer = SolutionPrinter(nodes)
  # Search for all soltuions 
  status = solver.SearchForAllSolutions(model, solution_printer)
  count, colors = solution_printer.SolutionCount()
  print("Solution found : %i" % count)
  print('Problem solved in ', solver.WallTime(), ' seconds')
  # Return the color values
  return colors

# Define number of nodes in the graph
num_nodes = 4
# Set number of colors as domain
domain = 4
# Add a connection for each edge.
connections = [
               (0, 2),
               (1, 2),
               (1, 3),
               (2, 0),
               (2, 1),
               (3, 1)
]
# Define the number of solutions required.
#num_solutions = 2

# call the graph coloring function to solve the graph for given colors.
#colors = graph_coloring(num_nodes, connections, domain, num_solutions)
colors = graph_coloring(num_nodes, connections, domain)