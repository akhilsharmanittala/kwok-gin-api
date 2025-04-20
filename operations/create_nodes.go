package operations

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"os/exec"
	"strconv"
	"time"
)

type response struct {
	NumberofNodes int `json:"number_of_nodes"`
	CreatedAt     string `json:"created_at"`
}

func CreateNodes(ctx *gin.Context) {
	
	nodesCount := 10
	cmd:= exec.Command("/bin/sh", "/opt/interceptor/create_nodes.sh", strconv.Itoa(nodesCount))
	err := cmd.Run()
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create nodes"})
		return
	}
	postresponse := response{
		NumberofNodes: nodesCount,
		CreatedAt:     time.Now().Format(time.RFC3339),
	}
	ctx.JSON(http.StatusOK, postresponse)
}