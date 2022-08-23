package token

import "time"

// Maker is an interface for managing token
type Maker interface {
	// CreateToken creates a new token for a specific username and duration
	CreateToken(username string, duration time.Duration) (string, error)

	// VerifyToken checks whether the token is valid
	VerifyToken(token string) (*Payload, error)
}
