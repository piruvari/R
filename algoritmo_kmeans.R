The k-means algorithm works in this way:
Step 1. Initialize the center of the clusters
Step 2. Assign the closest initial centers to each data point
Step 3. Set the position of each cluster to the mean of all data points belonging to that cluster
Step 4. Assign the closest cluster to each data point
Step 5. Repeat steps 3-4 until convergence

The k-means algorithm works in this way:
  #How does k-means work
  install.packages("sp")  
library(ggplot2)

set.seed(2009)
points1<-data.frame(x=rnorm(50,1,0.1),y=rnorm(50,5,0.1))
points2<-data.frame(x=rnorm(50,5,0.1),y=rnorm(50,5,0.1))
points3<-data.frame(x=rnorm(200,3,0.8),y=rnorm(200,3,0.8))
df<-rbind(points1,points2,points3)

#plot initial points
p <- ggplot(df, aes(x, y))
p + geom_point(size=7, color="grey")

#set initial centers
kcenters<-df[c(49,26,297),]

#plot centers
p + geom_point(size=7, color="grey") + geom_point(data=kcenters, aes(x, y), size=7, color="black", shape="x")

#assignment (to calculate distances to initial centers and to allocate points to the cluster to which they are closest)
library(reshape)
distances <- melt(as.matrix(dist(df,diag=T,upper = T)), varnames = c("row", "col"))
dist_center1<-subset(distances,col==49,select = value)
dist_center2<-subset(distances,col==26,select = value)
dist_center3<-subset(distances,col==297,select = value)
dist_centers<-data.frame(dist_center1,dist_center2,dist_center3)
colnames(dist_centers)<-c("dist_center1","dist_center2","dist_center3")
dist_centers$cluster<-apply(dist_centers, 1, which.min)
df<-cbind(df,dist_centers)