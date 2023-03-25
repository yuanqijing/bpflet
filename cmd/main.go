package cmd

import (
	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "bpflet",
	Short: "bpflet",
	Long:  "bpflet is a collector for bpf events",
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		panic(err)
	}
}
