class RequestsPdfCreatorService

  def create_and_save(requests)
    decorated = decorate(requests)
    html      = render_html(decorated)
    string    = WickedPdf.new.pdf_from_string(html)
    local_file_path(string)
  end

  def decorate(requests)
    RequestsDecorator.decorate(requests)
  end

  def render_html(decorated_requests)
    ApplicationController.render(
      template: 'requests/index',
      layout: 'pdf',
      assigns: {
        decorated: decorated_requests
      }
    )
  end

  def local_file_path(string)
    path = Rails.root.join('public', "#{SecureRandom.uuid}.pdf")
    File.open(path, 'wb') {|f| f << string }
    path
  end
end
