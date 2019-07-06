module ApplicationHelper
  def tailwindcss_class_for(flash_type)
    {
      notice: "info",
      error: "danger",
      alert: "warning",
      success: "success",
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end
end
