library(sparklyr)
library(dplyr)
library(ggplot2)

sc <- spark_connect(master = "local[4]")

iris_tbl <- sdf_copy_to(sc = sc, x = iris, overwrite = T)

iris_tbl %>% count()

iris_summary <- iris_tbl %>%
  mutate(Sepal_Width = ROUND(Sepal_Width * 2) / 2) %>% # Bucketizing Sepal_Width
  group_by(Species, Sepal_Width) %>%
  summarize(count = n(), Sepal_Length = mean(Sepal_Length)) %>%
  mutate(stdev = sd(Sepal_Length))

ggplot(iris_summary, aes(Sepal_Width, Sepal_Length, color = Species)) +
  geom_line(size = 1.2) +
  geom_errorbar(aes(ymin = Sepal_Length - stdev, ymax = Sepal_Length + stdev), width = 0.05) +
  geom_text(aes(label = count), vjust = -0.2, hjust = 1.2, color = "black") +
  theme(legend.position = "top")

fit1 <- ml_linear_regression(
  x = iris_tbl,
  response = "Sepal_Length",
  features = c("Sepal_Width", "Petal_Length", "Petal_Width")
)
summary(fit1)
