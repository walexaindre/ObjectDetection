function Apply(Matrix,MatrixFilter)
    filterRows,filterColumns = size(MatrixFilter)
    rangey = (filterRows-1)/2
    rangex = (filterColumns-1)/2

    for i in rangey+1:size(Matrix,1)-rangey
        for j in rangex+1:size(Matrix,2)-rangex
            # Get the submatrix
            subMatrix = Matrix[i-rangey:i+rangey,j-rangex:j+rangex]
            # Apply the filter
            Matrix[i,j] = sum(subMatrix .* MatrixFilter)
        end
    end

end