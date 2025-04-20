package main
import (	
	"github.com/gin-gonic/gin"
	op "github.com/akhilnittala/kwok-gin-api/operations" // Adjust the import path as necessary
)

func main() {
	r := gin.Default()
	r.POST("/v1/test", op.CreateNodes)
	r.Run(":3229") // listen and serve on
}