
# Neighbours and weigths
function Neighbours(mesh::Mesh,radius)

    # Alias
    ne = mesh.bmesh.ne

    # Maximum number of neighbours in the mesh
    num_max = 0

    # Tables to store the neighbours and weigts
    viz = Vector{Int64}[]
    weigths = Vector{Float64}[]

     # Loop for each element
     for ele=1:ne

         # Pega a posição do centróide do elemento central
         c_ele = Centroid(mesh,ele) 

         # Local Arrays
         viz_ele = Int64[]
         weigths_ele = Float64[]

         # Scan the mesh and store the neighbours of ele
         for j=1:ne

             # Centroid of j
             c_j = Centroid(mesh,j) 

             # Distance
             d = norm(c_j.-c_ele)

             # If inside the radius...
             if d<=R
                 push!(viz_ele,j)
                 push!(weigths_ele, 1.0 - d/R)
             end #if

         end #j

        # Assert if the element has neighbours
        length(viz_ele)>0 || throw("Neighbours:: element $ele does not have neighbours")

        # Maximum number of neighbours until now
        num_max = max(num_max,length(viz_ele))

        # Store the neighbours for ele
        push!(viz,viz_ele)
        push!(weigths,weigths_ele)

     end #ele

     # Return 
     return viz, weigths

end

