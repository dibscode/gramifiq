document.addEventListener("DOMContentLoaded", function () {
  var chatForm = document.getElementById("chatForm");
  var messageInput = document.getElementById("message");
  var responseDiv = document.getElementById("response");
  var submitBtn = chatForm.querySelector("button[type='submit']");

  chatForm.onsubmit = function (e) {
    e.preventDefault();
    var msg = messageInput.value;

    if (!msg.trim()) {
      alert("Silakan tulis pertanyaan terlebih dahulu.");
      return;
    }
    responseDiv.innerHTML = '<span style="color:gray">Memproses... Mohon tunggu.</span>';
    messageInput.disabled = true;
    if (submitBtn) submitBtn.disabled = true;
    fetch("api_handler.php?text=" + encodeURIComponent(msg))
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        if (data.status === true && data.result && data.result.text) {
          // Ganti **teks** menjadi <strong>teks</strong> agar tebal (multiline, non-greedy) sebelum escapeHtml
          let raw = data.result.text;
          let withBold = raw.replace(/\*\*(.+?)\*\*/gs, "<strong>$1</strong>");
          // Escape HTML untuk mencegah XSS, kecuali tag <strong>
          function escapeHtmlExceptStrong(text) {
            return text
              .replace(/&(?![a-zA-Z]+;)/g, "&amp;")
              .replace(/</g, function (m, offset) {
                // Jangan escape <strong>
                if (text.substr(offset, 8) === "<strong>") return "<";
                if (text.substr(offset, 9) === "</strong>") return "<";
                return "&lt;";
              })
              .replace(/>/g, function (m, offset) { 
                // Jangan escape <strong>
                if (text.substr(offset - 7, 8) === "<strong>") return ">";
                if (text.substr(offset - 8, 9) === "</strong>") return ">";
                return "&gt;";
              })
              .replace(/"/g, "&quot;")
              .replace(/'/g, "&#039;");
          }
          let safe = escapeHtmlExceptStrong(withBold);
          let formatted = safe.replace(/\n/g, "<br>");
          responseDiv.innerHTML = formatted;
        } else if (data.error) {
          responseDiv.innerHTML = '<span style="color:red">Terjadi kesalahan: ' + data.error + "</span>";
        } else {
          responseDiv.innerHTML = '<span style="color:red">Format respons tidak dikenali.</span>';
        }
      })
      .catch((err) => {
        responseDiv.innerHTML = '<span style="color:red">Error Kritis: Tidak bisa memproses permintaan. Pastikan file api_handler.php ada dan tidak rusak. (' + err.message + ")</span>";
      })
      .finally(() => {
        messageInput.disabled = false;
        if (submitBtn) submitBtn.disabled = false;
        messageInput.value = "";
        messageInput.focus();
      });
  };
});
