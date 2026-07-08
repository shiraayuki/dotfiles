local map = vim.keymap.set

-- Speichern & Suche
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Speichern" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Suche-Highlight aus" })

-- Fenster-Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Fenster links" })
map("n", "<C-j>", "<C-w>j", { desc = "Fenster unten" })
map("n", "<C-k>", "<C-w>k", { desc = "Fenster oben" })
map("n", "<C-l>", "<C-w>l", { desc = "Fenster rechts" })

-- Fenstergröße
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Fenster höher" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Fenster niedriger" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Fenster schmaler" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Fenster breiter" })

-- Buffer
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Voriger Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Nächster Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Buffer schließen" })

-- Zeilen verschieben (Alt+j/k)
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Zeile runter" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Zeile hoch" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Auswahl runter" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Auswahl hoch" })

-- Einrücken ohne Auswahl zu verlieren
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Diagnostics — ö/ä statt [d/]d (deutsches Layout, eckige Klammern brauchen AltGr)
map("n", "ö", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Vorige Diagnose" })
map("n", "ä", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Nächste Diagnose" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnose anzeigen" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnosen in Liste" })

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal-Modus verlassen" })
