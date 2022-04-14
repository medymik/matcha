package main

import (
	"github.com/gin-gonic/gin"
	docs "github.com/medymik/matcha/docs"
	ginSwagger "github.com/swaggo/gin-swagger"
	"github.com/swaggo/gin-swagger/swaggerFiles"
)

// @BasePath /api/v1
// @Summary ping health
// @Schemes
// @Description do ping
// @Tags Health
// @Accept json
// @Produce json
// @Success 200 {string} pong
// @Router /health/ping [get]
func HealthPing(ctx *gin.Context) {
	ctx.String(200, "pong")
}

func setupRouter() *gin.Engine {
	r := gin.Default()
	docs.SwaggerInfo.BasePath = "/api/v1"
	v1 := r.Group("/api/v1")
	{
		eg := v1.Group("/health")
		{
			eg.GET("/ping", HealthPing)
		}
	}
	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
	return r
}

func main() {
	r := setupRouter()
	r.Run(":8080")
}
